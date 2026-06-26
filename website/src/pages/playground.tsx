import BrowserOnly from '@docusaurus/BrowserOnly';
import Layout from '@theme/Layout';
import Playground from '@site/src/components/Playground';

export default function PlaygroundPage() {
  return (
    <Layout
      title="Playground"
      description="Transform CloudFormation templates and format ROS templates in your browser"
    >
      <BrowserOnly fallback={<main className="container margin-vert--lg">Loading playground...</main>}>
        {() => <Playground />}
      </BrowserOnly>
    </Layout>
  );
}
