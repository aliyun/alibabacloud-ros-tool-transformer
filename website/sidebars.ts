import type {SidebarsConfig} from '@docusaurus/plugin-content-docs';

const sidebars: SidebarsConfig = {
  docsSidebar: [
    'intro',
    'installation',
    {
      type: 'category',
      label: 'Usage',
      link: {type: 'doc', id: 'usage'},
      items: [
        'usage/transform',
        'usage/format',
        'usage/rules',
        'usage/web-service',
      ],
    },
    {
      type: 'category',
      label: 'Examples',
      items: [
        'examples/terraform-to-ros',
        'examples/terraform-to-ros-compatible',
        'examples/ros-terraform-to-terraform',
        'examples/cloudformation-to-ros',
        'examples/excel-to-ros',
        'examples/ros-to-terraform',
      ],
    },
    {
      type: 'category',
      label: 'Supported Types',
      items: [
        'supported-types/terraform',
        'supported-types/cloudformation',
        'supported-types/ros-to-terraform',
      ],
    },
  ],
};

export default sidebars;
