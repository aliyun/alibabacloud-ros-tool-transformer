import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: 'ROS Template Transformer',
  tagline: 'Transform and format cloud resource templates',
  favicon: 'img/logo.svg',

  future: {
    v4: true,
  },

  url: 'https://aliyun.github.io',
  baseUrl: '/alibabacloud-ros-tool-transformer/',

  organizationName: 'aliyun',
  projectName: 'alibabacloud-ros-tool-transformer',

  onBrokenLinks: 'throw',
  clientModules: ['./src/clientModules/localeRedirect.mjs'],

  i18n: {
    defaultLocale: 'en',
    locales: ['en', 'zh-cn'],
    localeConfigs: {
      en: {
        label: 'English',
      },
      'zh-cn': {
        label: '中文',
      },
    },
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          routeBasePath: '/',
          editUrl:
            'https://github.com/aliyun/alibabacloud-ros-tool-transformer/tree/master/website/',
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    colorMode: {
      respectPrefersColorScheme: true,
    },
    navbar: {
      title: 'ROS Template Transformer',
      logo: {
        alt: 'ROS Template Transformer logo',
        src: 'img/logo.svg',
      },
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'docsSidebar',
          position: 'left',
          label: 'Docs',
        },
        {
          to: '/playground',
          label: 'Playground',
          position: 'left',
        },
        {
          type: 'localeDropdown',
          position: 'right',
        },
        {
          href: 'https://github.com/aliyun/alibabacloud-ros-tool-transformer',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            {
              label: 'Introduction',
              to: '/',
            },
            {
              label: 'Installation',
              to: '/installation',
            },
            {
              label: 'Usage',
              to: '/usage',
            },
          ],
        },
        {
          title: 'More',
          items: [
            {
              label: 'GitHub',
              href: 'https://github.com/aliyun/alibabacloud-ros-tool-transformer',
            },
            {
              label: 'PyPI',
              href: 'https://pypi.org/project/alibabacloud-ros-tran/',
            },
            {
              label: 'Alibaba Cloud ROS',
              href: 'https://www.alibabacloud.com/product/ros',
            },
          ],
        },
      ],
      copyright: `Copyright © 2020-${new Date().getFullYear()} Alibaba Cloud. Built with Docusaurus.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
      additionalLanguages: ['bash', 'json', 'yaml', 'hcl', 'python'],
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
