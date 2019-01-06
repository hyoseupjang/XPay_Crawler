# The-Communist-Manifesto
흑우같이 설정된 서버에서 XPay 모듈에서 나온 로그들을 가져옵니다. 내가 미쳤다고 bash로 짰지... ㅂㄷㅂㄷ

LG XPay 결제 모듈에서 나온 로그를 html 폴더 안에 집어넣는 말랑서버들에게 경각심을 주고자(맞음) 제작되었습니다. 다음과 같은 한계가 존재하고, 다음과 같은 상황에 대응합니다. 

문제가 되는 상황
1. 제대로 설정한 서버
2. 디렉토리 리스팅이 비활성화 되어 있고, 금일에 생성된 로그가 없는 경우. 
3. 어떤 파일에 접근하던지 200을 띄우는 해괴한 서버들. 
4. XPay Plugin의 설치 위치가 다른 서버들. 

제대로 되는 상황
1. 디렉터리 리스팅을 로그 파일이 있는 위치에다가 활성화한 제 정신이 아닌 서버들. 
2. 1.에 해당하지 않더라도, 로그 파일에 직접 접근이 가능하며, 금일에 생성된 로그가 있는 경우들. (아직 테스트 안 해봄. 되겠지 뭐)

의존성
1. Wget
2. Bash

대한민국 법에 의해, 배포 라이선스와 무관하게 공익적인 목적의 사용만 허가합니다. 공익적인 목적 아래에서는 라이선스에 따라 자유롭게 사용하시면 됩니다. 
