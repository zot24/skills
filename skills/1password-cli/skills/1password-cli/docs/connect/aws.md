> Source: https://www.1password.dev/connect/aws/



> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Integrations


Deploy 1Password Connect Server on AWS ECS Fargate


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/tutorials" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Tutorials</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Integrations


# Deploy 1Password Connect Server on AWS ECS Fargate


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password</a>.
- <a href="/connect/get-started#step-1" class="link">Create a 1Password Connect server</a> in your infrastructure.
- Sign up with <a href="https://docs.aws.amazon.com/AmazonECS/latest/userguide/what-is-fargate.html" class="link" target="_blank" rel="noreferrer">AWS Fargate</a> .

## 


<a href="#example" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#resources" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- A virtual private cloud (VPC)
- Two public subnets
- An <a href="https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-internetgateway.html" class="link" target="_blank" rel="noreferrer">Internet gateway</a>
- An <a href="https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html" class="link" target="_blank" rel="noreferrer">Application Load Balancer (ALB)</a>


- An <a href="https://docs.aws.amazon.com/AmazonECS/latest/userguide/clusters-concepts.html" class="link" target="_blank" rel="noreferrer">ECS cluster</a>
- Two <a href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-tasks-services.html" class="link" target="_blank" rel="noreferrer">task definitions</a>
  - A `1password/connect-api` container
  - A `1password/connect-sync` container

## 


<a href="#get-started" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <a href="https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-console-create-stack.html#cfn-using-console-initiating-stack-creation" class="link" target="_blank" rel="noreferrer">Start the <strong>AWS Create Stack</strong> wizard.</a>
2.  Select the example <a href="https://github.com/1Password/connect/blob/main/examples/aws-ecs-fargate/connect-server.yaml" class="link" target="_blank" rel="noreferrer"><code>connect-server.yaml</code> file</a> as the stack template. See <a href="https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-using-console-create-stack-template.html" class="link" target="_blank" rel="noreferrer">Selecting a stack template</a> .
3.  Provide a Base64 URL encoded version of your Connect server’s `1password-credentials.json` file.


``` shiki
cat 1password-credentials.json | base64 | tr '/+' '_-' | tr -d '=' | tr -d '\n'
```


Related topics

<a href="/connect/aws-ecs-fargate" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Deploy 1Password Connect Server on AWS ECS Fargate with CloudFormation</span></a><a href="/get-started/secure-deployment" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Secure CI/CD and deployments with 1Password</span></a><a href="/integrations" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">1Password integrations</span></a>


Was this page helpful?


<a href="/connect/ansible" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Ansible</span></a><a href="/connect/ci-cd" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">CI/CD integrations</span></a>


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


