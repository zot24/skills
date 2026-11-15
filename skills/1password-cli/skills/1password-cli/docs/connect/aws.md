> Source: https://www.1password.dev/connect/aws/



Infrastructure tools


# Deploy 1Password Connect Server on AWS ECS Fargate with CloudFormation


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_39deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password</a>.
- <a href="/connect/get-started/#step-1" class="link">Create a 1Password Connect server</a> in your infrastructure.
- Sign up with <a href="https://docs.aws.amazon.com/AmazonECS/latest/userguide/what-is-fargate.html" class="link" target="_blank" rel="noreferrer">AWS Fargate.</a>

## <a href="#example" class="anchor-link" aria-label="Navigate to header: Example"></a><span id="_R_99deehkd74t9_" class="min-w-0 break-words cursor-pointer">Example</span>


### <a href="#resources" class="anchor-link" aria-label="Navigate to header: Resources"></a><span id="_R_j9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Resources</span>


- A virtual private cloud (VPC)
- Two public subnets
- An <a href="https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-internetgateway.html" class="link" target="_blank" rel="noreferrer">Internet gateway</a>
- An <a href="https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html" class="link" target="_blank" rel="noreferrer">Application Load Balancer (ALB)</a>


- An <a href="https://docs.aws.amazon.com/AmazonECS/latest/userguide/clusters-concepts.html" class="link" target="_blank" rel="noreferrer">ECS cluster</a>
- Two <a href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-tasks-services.html" class="link" target="_blank" rel="noreferrer">task definitions</a>
  - A `1password/connect-api` container
  - A `1password/connect-sync` container

## <a href="#get-started" class="anchor-link" aria-label="Navigate to header: Get started"></a><span id="_R_t9deehkd74t9_" class="cursor-pointer">Get started</span>


1.  <a href="https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-console-create-stack.html#cfn-using-console-initiating-stack-creation" class="link" target="_blank" rel="noreferrer">Start the <strong>AWS Create Stack</strong> wizard.</a>
2.  Select the example <a href="https://github.com/1Password/connect/blob/main/examples/aws-ecs-fargate/connect-server.yaml" class="link" target="_blank" rel="noreferrer"><code>connect-server.yaml</code> file</a> as the stack template. See <a href="https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-using-console-create-stack-template.html" class="link" target="_blank" rel="noreferrer">Selecting a stack template.</a>
3.  Provide a Base64 URL encoded version of your Connect server’s `1password-credentials.json` file.


``` shiki
cat 1password-credentials.json | base64 | tr '/+' '_-' | tr -d '=' | tr -d '\n'
```


Was this page helpful?


