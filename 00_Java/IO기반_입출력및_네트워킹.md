### 220707 IO기반 입출력 및 네트워킹

- 배울 클래스들

  - **입출력 기능 클래스** `java.io.*`

    - ![스크린샷 2022-07-07 오후 3.35.33](/Users/choeyunseo/Desktop/스크린샷 2022-07-07 오후 3.35.33.png)
      - 자바 프로그램 -> 모니터 : 출력 (`System.out`)
      - 키보드 -> 자바 프로그램 : 입력 `System.in`
      - 로컬 파일 -> 자바 프로그램 : 입력 

    - 

  - |                          | 입력                               | 출력                               |
    | ------------------------ | ---------------------------------- | ---------------------------------- |
    | 단위 - 1byte씩(다국어 x) | xxxinputStream                     | xxxoutputStream                    |
    | 단위 - 2byte씩           | xxxReader                          | xxxWriter                          |
    | 입출력기능과 무관        | File - 파일이나 디렉토리 정보 제공 | File - 파일이나 디렉토리 정보 제공 |

  

  - **네트워크 통신 클래스** `java.net.*`

  - |             | 서버                         | 클라이언트                   |
    | ----------- | ---------------------------- | ---------------------------- |
    | TCP         | ServerSocket                 | Socket                       |
    | UDP         | DatagramSoket/ DatagramPaket | DatagramSoket/ DatagramPaket |
    | 통신과 무관 | InetAddress - ip 주소 정보   | InetAddress - ip 주소 정보   |

