# AWS 3 Tier Architecture VPC

## 실행방법

```
  source alias.sh
  tf workspace new [mode]

  tf init && tf plan -var-file=tf.tfvars
  tf apply -var-file=tf.tfvars
```

## Architecture

![3-ter](./public/3-tier.png)

## Caution

- ap-northeast-2의 경우 t3로 진행해야 함 (t2는 불가)
- t3.nano는 ssh provisioning이 안됨... 네트워크 불량? + 저사양? => t3.micro 이상으로 해야함
