## 220630 깃허브 특강 2
### 1. git/ github
- 복구 , 백업 , 협력을 하기위해 사용

### 2. git push / pull 
- 해당 레포지토리에 콜라보레이터로 등록된 유저는 `pull` , `push` 가능
- 브랜치랑 폴더 위치 확인 잘하기!

### 3. git clone [repo url]
- 레포지토리 복사

### 4. git branch
- 브랜치 사용시 병렬 구조로 개발 가능
- HEAD는 현재 브랜치를 가리키는 포인터
- 브랜치 이동 전에 `commit` 하기!
    - `git branch` : 모든 브랜치 확인
    - `git switch -c [branch]` : 브랜치 생성후 이동
    - `git switch  [branch]` : 브랜치로 HEAD 이동
    - `git branch -D [브랜치]` : 브랜치 삭제
    - `git merge [브랜치]` : 브랜치가 보고 있는 커밋으로 해당 브랜치 이동(Fast-Forward)
    - `git log --online --all` : 브랜치 전체 로그 확인

### 5. 권한이 없는 경우의 협력
- `push` 또는  `pull`할 권한이 없을 때 해당 레포지토리의 fork를 떠온다.
- 자신의 레포지토리 리스트에 fork 떠온게 추가된 것을 확인 할 수 있다.
- 그 레포지토레에 작업한 것을 올린 후 `Pull Request` 요청한다.
    - 브랜치 파면 더 좋다.
    - 포크 떠온 레포지토리의 권한은 오로지 본인에게 있기때문에 브랜치를 생성하거나 않거나는 본인의 자유
- 레포지토리 주인이 `PR` 을 확인하고 `merge` 하거나 거절한다.