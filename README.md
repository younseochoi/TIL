# linux 명령어
- ls : 폴더안에 있는 파일 리스트 출력
-  cd : 해당 폴더로 이동
- mkdir : 폴더생성
- rm -r : 파일 삭제

--- 

# CLI 와 GUI ?
- CLI 는 명령어 기반, GUI 는 그래픽 기반 사용자 인터페이스이다.

--- 

# MarkDown 이란?
1. 일반 텍스트기반의 경량 마크업 언어
2. ### 큰 제목 
3. *기울이기*
4. ~~취소~~
5.  **볼드**
6. [string](www.naver.com)
7. option + command + t 표생성 

---

# Git 이란?
1. git init을 하면 로컬 저장소가 생긴다.
    - 로컬 저장소는 working directory -> staging area -> repository 로 구성
        - working directory : 사용자가 작업을 수행하는 공간
        - staging area : 커밋을 위한 파일 및 폴더가 추가되는 공간
        - repository : staging area 에 있는 파일및 폴더 변경사항 저장

2. 파일을 생성 or 수정하고 git add 
    - 로컬 저장소 : working directory -> staging area
    - git status 를 통해 현재 파일의 상태를 파악

3. git commit
    - staging area 에 올라온 파일의 변경사항을 하나의 커밋으로 저장
    - 로컬 저장소 : staging area -> repository
    - git log 를 통해 커밋된 내용 파악
        - git log --oneline

--- 

# Github 란?
- 원격 저장소와 로컬 저장소를 연결시켜줌
1. github 에서 레포지토리 생성
2. 올리고 싶은 폴더로 이동 후 git init
    - git config user.name
    - git config user.email
3. 원격 저장소 등록 git remote add [별명 ex)origin] rep주소
    - 조회는 git remote -v
    - 삭제는 git remote rm [별명]
        - 연결을 끊는 것일 뿐 원격 저장소 삭제가 아님
4. git add 와 git commit 이 되었다면 git push [별명] master
    - 최초 한 번은 git push -u [별명] master

--- 