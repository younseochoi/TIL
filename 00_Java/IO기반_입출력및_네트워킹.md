### 220707 IO기반 입출력 및 네트워킹

- 배울 클래스들

  - **입출력 기능 클래스** `java.io.*`
    - 자바 프로그램 내부 데이터 받아온다 = 입력
      - 자바프로그램에  `.txt`파일에서 문자를 읽어온다 = (input)
      - 키보드, 메모리 버퍼, 파일
    - 자바 프로그램 외부로 데이터를 보낸다 = 출력
      - 자바프로그램에서  `.txt`파일로 문자를 저장한다 = (output)
      - 모니터, 메모리버퍼 ,파일
        - ~~(모니터 출력 개념이 익숙한 나머지 자바프로그램에서 input으로 파일을 읽어와 출력하는게 출력이 아닌가? 생각하기도 했음 )~~
    - 자바 프로그램 -> 모니터 : 출력 (`System.out`)
    - 키보드 -> 자바 프로그램 : 입력 `System.in`
    - 로컬 파일 -> 자바 프로그램 : 입력 
    - ![스크린샷 2022-07-07 오후 3.35.33](/Users/choeyunseo/Desktop/스크린샷 2022-07-07 오후 3.35.33.png)

  - |                          | 입력                               | 출력                               |
    | ------------------------ | ---------------------------------- | ---------------------------------- |
    | 단위 - 1byte씩(다국어 x) | xxxinputStream                     | xxxoutputStream                    |
    | 단위 - 2byte씩           | xxxReader                          | xxxWriter                          |
    | 입출력기능과 무관        | File - 파일이나 디렉토리 정보 제공 | File - 파일이나 디렉토리 정보 제공 |

  

  - **입력스트림**

    - 1byte(바이트 스트림) - 영문자, 이미지(.jpg), 음향(.mp3) 

      - ```java
        abstract class InputStream{read(); 구현(){}}
        
        FileInputStream extends InputStream{read(){구현}} 
        // InputStream /xxxxInputStream 도 마찬가지!
        ```

      - `read()` - 데이터 1바이트씩 입력  

      - `close()`- 공통

    - 2byte(문자스트림)- 다국어

      - ```java
        Reader / xxxReader/ read() - 데이터 2바이트씩 입력 
        ```

      - `close()`- 공통 `finally` 블록 처리

  - **출력스트림**

    - 1byte(바이트 스트림) - 영문자, 이미지(.jpg), 음향(.mp3) 
      - `OutputStream`,`xxxxOutputStream`,` FileOutputStream` `write(1바이트데이터)`
      - `close()`- 공통
    - 2byte(문자스트림)- 다국어
      - `Writer` / `xxxWriter` /`write(2바이트 데이터)`/`write(String - 1개문자 2바이트)`
      - ` close()`- 공통

  - **그 외**

    - File- window- 탐색기, Mac- 파일 관리자 

      => 파일이나 디렉토리 취급가능, 자바에서 구현 가능

      

  #### **콘솔 입출력**

  - 콘솔 입력 - 키보드 입력 - 표준 입력

    - `System.in` : 현재 자바 실행 시스템 키보드 변수

      - `System.in.read()` : 1byte씩 입력받는 메소드 `read()` 호출

        - 키 하나의 유니코드 `int` 로 리턴함. => 한글 입력 불가능

          

  - 콘솔 출력 - 모니터 출력 - 표준 출력

    - `System.out` : 현재 자바 실행 시스템 모니터 변수

      - `System.out.print()` : 현재 자바 실행 프로그램 모니터에 출력 
        - 이 메소드는 오버로딩 되어있어 문자, 숫자 등 다양하게 출력 가능

    - ```java
      class System{
        static InputStream in; 
        static PrintStream out; //OuputStream 상속
      }
      ```

  - `java.util.Scanner`

    - 다양한 타입을 입력받을 수 있음

    - ```java
      Scanner s = new Scanner(System.in);
      int result = s.nextInt();
      double d =  s.nenxtDouble();
      boolean b = s.nextBooolean();
      //nextxxx()
      String result1 = s.next(); //한개 단어 - 문자열(문자열 내부 모든 문자들은 2바이트)
      String result2 = s.nextLine(); //1줄 입력
      ```

  

  #### 파일 입출력

  - **File 클래스**

    - 용도 : os 파일시스템(파일, 디렉토리) 관리 기능 제공

    - 입출력 기능 메소드는 없음

    - `File f = new File("a.txt");` 

      - `a.txt` 가 존재하지 않아도 오류 x 

    - 메소드

      ```java
      File f = new File(name);
      f.exists(); //디렉토리 또는 파일이 존재하는지	
      f.mkdir(); //디렉토리가 존재하지 않는다면 생성
      f.isFile(); //파일인지 아닌지 (아니라면 디렉토리)
      
      //f가 파일이라면
      f.length(); //파일 크기(byte 단위)
      f.getCanonicalPath(); //파일 전체 경로
      f.canRead(); //파일 읽기 가능 여부
      f.canWrite(); //파일 쓰기 가능 여부
      f.lastModified(); //파일 마지막 수정일자 -> 1/1000
      
      //f가 디렉토리라면
      String[] details = f.list(); //디렉토리 내부 세부사항
      
      ```

      

  - **FileInputStream**

    - 용도 - 파일 내용 입력, 1바이트 입력 가능

    - ```java
      FileInputStream fi = new FileInputStream("입력파일명");
      //입력파일명이 없으면 에러
      ```

    - 메소드 (`read()`/`close()`)

      - ```java
        FileInputStream fi = new FileInputStream("입력파일명");
        
        int i = fi.read(); //한문자씩 읽음
        // fi.read() == -1이라면 파일 다 읽은 것 (EOF)
        
        while(true){
          int result = fi.read();
          if(result == -1) break;
        }
        fi.close();
        ```

      - `IoException`  처리 필수

  - **FileOutputStream**

    - 용도 - 파일에 문자 출력 -1byte씩 출력 가능(문자하나)

    - ```java
      FileOutputStream fi = new FileOutputStream("입력파일명",/*true or false*/);
      
      //출력할 파일이 경로에 존재 o -false or 매개변수 없거나  -  기존 파일 내용은? 삭제후 새로운 내용으로 write 
      
      //출력할 파일이 경로에 존재 o -true -  기존 파일 내용은? 유지 후 추가 write 
      
      //출력할 파일이 경로에 존재 x - 파일 자동 생성 
      ```

    - 메소드 (`read()`/`close()`)

      - ```java
        FileOutputStream fo = new FileOutputStream("src/chap18/b.java",true); 
        			//os에게 파일 접근 허락 요청  - os 수락 
        	fo.write(66);
        	fo.write('B');
        	fo.write('\n');
        	fo.close();
        ```

  - **FileReader **

    - 용도 - 파일 내용 입력, 2바이트 입력 가능, 한글 입력 가능

    - ```java
       FileReader fi = new FileReader("입력파일명");
      
      while(true){
        int result = fi.read(); // 2바이트씩 한글가능
        if(result == -1) break;
      }
      fi.close();
      
      ```

    - 

  - **FileWriter**

    - 용도 - 파일 내용 출력, 2바이트 출력 가능, 한글 출력 가능

    - ```java
      FileWriter fi = new FileWriter("출력 파일명",/*true or false*/);
      fi.write("가나다");
      fi.close();
      ```

  - **파일에서 문자열을 입력받아 연산을 하고싶다면?**

    - ![스크린샷 2022-07-08 오후 3.19.16](IO기반_입출력및_네트워킹.assets/스크린샷 2022-07-08 오후 3.19.16.png)

    - `Scanner ` 를 통해 가공한다

    - ```java
      Scanner sc = new Scanner(new FileInputStream(""));
        
      Scanner sc = new Scanner(new FileReader(""));
        
      sc.nextInt(); //파일 내용을 int로 받아 연산 할 수 있음
      sc.nextLine();
      
      //파일끝까지 반복  현재줄에 입력할수 있는 내용이 있는지 판단후 다음줄 이동
      while(sc.hasNextLine()) {  
      				String fileline = sc.nextLine(); // '\n' 는 판단 기준 포함시키지 않음 
      				fw.write(linestr+fileline+"\n"); // 파일에 줄바꿔쓰고 싶다면 '\n' 포함 시켜주어야함.
      				
      			}
      ```

    - `scanner.hasNextLine()` vs `scanner.hasNext()`

      - `scanner.hasNextLine()`은 다음에 읽을 값이 있는지 확인하는  불린타입의 메소드로 값이 있으면 트루를 반환한다.
      - 단어 단위로 받아오고싶으면 `scanner.hasNext()`

      

  ---

  

  - **네트워크 통신 클래스** `java.net.*`

  - |             | 서버                         | 클라이언트                   |
    | ----------- | ---------------------------- | ---------------------------- |
    | TCP         | ServerSocket                 | Socket                       |
    | UDP         | DatagramSoket/ DatagramPaket | DatagramSoket/ DatagramPaket |
    | 통신과 무관 | InetAddress - ip 주소 정보   | InetAddress - ip 주소 정보   |

