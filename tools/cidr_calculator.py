import ipaddress


def main():
    """
        사용가능한 ip 주소를 찾습니다 (cidr block)
    """
    cidr = input("cidr_block >> ")
    ip_network = ipaddress.ip_network(cidr)
    print(f"{cidr} 사용가능한 host 개수 : {ip_network.num_addresses - 2}")


if __name__ == "__main__":
    main()
