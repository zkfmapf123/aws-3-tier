# AWS 3 Tier Architecture

## Architecture

![3-tier](./public/3-tier.png)
![3-tier-example](./public/3-tier-example.png)

## Services

- VPC

  [x] Subnets

  - [x] WebServer (Public)
  - [x] WAS (Private)
  - [x] DB (Private)
  - [x] NAT gateways
  - [x] Internet gateways

- 1 Tier (WebServer)

  - [ ] EC2
  - [ ] Security Group
  - [ ] nginx

- 2 Tier (WAS)

  - EC2
  - Security Group
  - Auto Scaling
  - Application Load Balancer

- 3 Tier (Database)

  - [ ] RDS
