#### 스프링부트 오류모음

- `Invalid bound statement (not found)`: 에러가 발생하는 이유가 몇 가지 있는데 아무리 찾아봐도 내 문제는 해결되지 않았다.

  에러 원인은 아래와 같다.

  1. Mapper Interface와 mapping되는 xml파일에 오타가 있는 경우 : 예를 들면 id와 Interface에 메소드명이 일치하지 않는 경우
  2. classpath에 경로가 잘못된 경우
  3. xml이 저장될 경로는 잘못 생성한 경우
  4. 나같은 경우는 매핑파일 이름이 달라서였다. 
  5. 매핑 파일의 태그 id와 dao의 메소드 이름이 일치하지 않아서였다.
  6. 나 같은 경우는 서비스@Service 어노테이션에 boardService와 같이 대문자와 소문자가 섞인경우에 bean 설정에 충돌이 나서 서버자체가 실행이 안되었다. 해결방법은 boardservice 소문자만 @Service("boardservice")라고 선언해주었다.

---

