FROM ubuntu:impish
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER aritha
RUN echo aritha
CMD echo aritha
COPY . .


RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get upgrade -y && apt-get install -y sudo curl apt-utils libqt5gui5 python3-psutil wget python3 python3-pip p7zip-full git build-essential

RUN wget --no-check-certificate -nv "https://gitlab.com/OIVAS7572/Goi5.1.bin/-/raw/MEGA/Goi5.1.bin.7z" -O Goi5.1.bin.7z \
&& 7z e Goi5.1.bin.7z && rm Goi5.1.bin.7z
RUN wget --no-check-certificate "https://gitlab.com/OIVAS7572/Cerebellum3merge.bin/-/raw/master/Cerebellum3Merge.bin.7z" -O Cerebellum3Merge.bin.7z
Run 7z e Cerebellum3Merge.bin.7z && rm Cerebellum3Merge.bin.7z

#add variant books 
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/antichess.bin" -O antichess.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/atomic.bin" -O atomic.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/horde.bin" -O horde.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/racingKings.bin" -O racingKings.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/threeCheck.bin" -O threeCheck.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/kingOfTheHill.bin" -O kingofthehill.bin
RUN wget --no-check-certificate "https://abrok.eu/stockfish/builds/eae0f8dd066b31102b6663a60c36fffccf4e1269/linux64modern/stockfish_22030820_x64_modern.zip" -O chess-engine.zip
RUN 7z e chess-engine.zip && rm chess-engine.zip && mv stockfish* chess-engine


RUN wget --no-check-certificate "https://github.com/SriMethan/lic-bot-heroku/raw/main/engines/fsf" -O fsf
RUN wget --no-check-certificate "https://github.com/TheDarkGrandmaster2/masterbotheroku/raw/master/engines/lsf" -O lsf
 
COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt


RUN chmod +x chess-engine
RUN chmod +x fsf
RUN chmod +x lsf
# Engine name is here ^^^^^^

CMD python3 run.py
