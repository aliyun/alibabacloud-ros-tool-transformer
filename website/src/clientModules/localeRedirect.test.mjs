import assert from 'node:assert/strict';
import test from 'node:test';

import {
  getPreferredLocale,
  getLocaleRedirectUrl,
} from './localeRedirect.mjs';

const baseUrl = '/alibabacloud-ros-tool-transformer/';

test('uses the zh-cn locale for Chinese browser language variants', () => {
  assert.equal(getPreferredLocale(['zh-CN', 'en-US']), 'zh-cn');
  assert.equal(getPreferredLocale(['zh-Hans-CN', 'en-US']), 'zh-cn');
  assert.equal(getPreferredLocale(['zh']), 'zh-cn');
});

test('falls back to the default locale for unsupported browser languages', () => {
  assert.equal(getPreferredLocale(['fr-FR', 'de-DE']), 'en');
  assert.equal(getPreferredLocale([]), 'en');
});

test('redirects default-locale pages to the preferred localized page', () => {
  assert.equal(
    getLocaleRedirectUrl({
      baseUrl,
      languages: ['zh-CN'],
      pathname: '/alibabacloud-ros-tool-transformer/usage',
      search: '?from=docs',
      hash: '#examples',
    }),
    '/alibabacloud-ros-tool-transformer/zh-cn/usage?from=docs#examples',
  );
});

test('redirects the site root to the preferred localized root', () => {
  assert.equal(
    getLocaleRedirectUrl({
      baseUrl,
      languages: ['zh-CN'],
      pathname: '/alibabacloud-ros-tool-transformer/',
    }),
    '/alibabacloud-ros-tool-transformer/zh-cn/',
  );
});

test('does not redirect already-localized pages', () => {
  assert.equal(
    getLocaleRedirectUrl({
      baseUrl,
      languages: ['zh-CN'],
      pathname: '/alibabacloud-ros-tool-transformer/zh-cn/usage',
    }),
    null,
  );
});

test('does not redirect non-Chinese browsers or URLs outside the site base', () => {
  assert.equal(
    getLocaleRedirectUrl({
      baseUrl,
      languages: ['en-US'],
      pathname: '/alibabacloud-ros-tool-transformer/usage',
    }),
    null,
  );
  assert.equal(
    getLocaleRedirectUrl({
      baseUrl,
      languages: ['zh-CN'],
      pathname: '/other-site/usage',
    }),
    null,
  );
});
