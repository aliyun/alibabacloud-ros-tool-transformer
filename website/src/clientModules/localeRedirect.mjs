const DEFAULT_LOCALE = 'en';
const SUPPORTED_LOCALES = ['en', 'zh-cn'];
const BASE_URL = '/alibabacloud-ros-tool-transformer/';
const REDIRECT_SESSION_KEY = 'ros-tool-transformer.localeRedirected';

function normalizeLanguage(language) {
  return typeof language === 'string'
    ? language.trim().toLowerCase().replace(/_/g, '-')
    : '';
}

function normalizeBaseUrl(baseUrl) {
  const withLeadingSlash = baseUrl.startsWith('/') ? baseUrl : `/${baseUrl}`;
  return withLeadingSlash.endsWith('/')
    ? withLeadingSlash
    : `${withLeadingSlash}/`;
}

function getPathWithinBase(pathname, baseUrl) {
  const normalizedBaseUrl = normalizeBaseUrl(baseUrl);

  if (normalizedBaseUrl === '/') {
    return pathname.startsWith('/') ? pathname.slice(1) : null;
  }

  const baseWithoutTrailingSlash = normalizedBaseUrl.slice(0, -1);
  if (pathname === baseWithoutTrailingSlash || pathname === normalizedBaseUrl) {
    return '';
  }

  if (!pathname.startsWith(normalizedBaseUrl)) {
    return null;
  }

  return pathname.slice(normalizedBaseUrl.length);
}

function getSupportedLocaleMap(supportedLocales) {
  return supportedLocales.map((locale) => ({
    locale,
    normalized: normalizeLanguage(locale),
  }));
}

export function getPreferredLocale(
  languages,
  {supportedLocales = SUPPORTED_LOCALES, defaultLocale = DEFAULT_LOCALE} = {},
) {
  const supportedLocaleMap = getSupportedLocaleMap(supportedLocales);

  for (const language of languages ?? []) {
    const normalizedLanguage = normalizeLanguage(language);
    if (!normalizedLanguage) {
      continue;
    }

    const directMatch = supportedLocaleMap.find(
      ({normalized}) => normalized === normalizedLanguage,
    );
    if (directMatch) {
      return directMatch.locale;
    }

    const primaryLanguage = normalizedLanguage.split('-')[0];
    const primaryMatch = supportedLocaleMap.find(
      ({normalized}) =>
        normalized === primaryLanguage ||
        normalized.startsWith(`${primaryLanguage}-`),
    );
    if (primaryMatch) {
      return primaryMatch.locale;
    }
  }

  return defaultLocale;
}

export function isLocalizedPath(
  pathname,
  {
    baseUrl = BASE_URL,
    supportedLocales = SUPPORTED_LOCALES,
    defaultLocale = DEFAULT_LOCALE,
  } = {},
) {
  const pathWithinBase = getPathWithinBase(pathname, baseUrl);
  if (pathWithinBase === null) {
    return false;
  }

  const [firstSegment] = pathWithinBase.split('/');
  const localizedPrefixes = supportedLocales
    .filter((locale) => locale !== defaultLocale)
    .map(normalizeLanguage);
  return localizedPrefixes.includes(normalizeLanguage(firstSegment));
}

export function getLocaleRedirectUrl({
  baseUrl = BASE_URL,
  languages,
  pathname,
  search = '',
  hash = '',
  supportedLocales = SUPPORTED_LOCALES,
  defaultLocale = DEFAULT_LOCALE,
}) {
  const pathWithinBase = getPathWithinBase(pathname, baseUrl);
  if (
    pathWithinBase === null ||
    isLocalizedPath(pathname, {baseUrl, supportedLocales, defaultLocale})
  ) {
    return null;
  }

  const preferredLocale = getPreferredLocale(languages, {
    supportedLocales,
    defaultLocale,
  });
  if (preferredLocale === defaultLocale) {
    return null;
  }

  const normalizedBaseUrl = normalizeBaseUrl(baseUrl);
  const localizedPath = pathWithinBase
    ? `${preferredLocale}/${pathWithinBase}`
    : `${preferredLocale}/`;
  const normalizedSearch =
    search && !search.startsWith('?') ? `?${search}` : search;
  const normalizedHash = hash && !hash.startsWith('#') ? `#${hash}` : hash;

  return `${normalizedBaseUrl}${localizedPath}${normalizedSearch}${normalizedHash}`;
}

function getBrowserLanguages(browserWindow) {
  const languages = browserWindow.navigator?.languages;
  if (Array.isArray(languages) && languages.length > 0) {
    return languages;
  }

  return browserWindow.navigator?.language ? [browserWindow.navigator.language] : [];
}

function getSessionStorage(browserWindow) {
  try {
    return browserWindow.sessionStorage;
  } catch {
    return null;
  }
}

function hasRedirected(storage) {
  try {
    return storage?.getItem(REDIRECT_SESSION_KEY) === 'true';
  } catch {
    return false;
  }
}

function rememberRedirect(storage) {
  try {
    storage?.setItem(REDIRECT_SESSION_KEY, 'true');
  } catch {
    // Ignore storage failures in privacy-restricted browser contexts.
  }
}

export function runBrowserLocaleRedirect(browserWindow = globalThis.window) {
  if (!browserWindow?.location) {
    return;
  }

  const storage = getSessionStorage(browserWindow);
  const {pathname, search, hash} = browserWindow.location;

  if (isLocalizedPath(pathname)) {
    rememberRedirect(storage);
    return;
  }

  if (hasRedirected(storage)) {
    return;
  }

  const redirectUrl = getLocaleRedirectUrl({
    languages: getBrowserLanguages(browserWindow),
    pathname,
    search,
    hash,
  });

  if (redirectUrl) {
    rememberRedirect(storage);
    browserWindow.location.replace(redirectUrl);
  }
}

runBrowserLocaleRedirect();
