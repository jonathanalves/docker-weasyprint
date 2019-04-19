FROM alpine:latest

RUN apk --no-cache add msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f
	
RUN apk --update --upgrade add bash cairo pango gdk-pixbuf py3-cffi py3-pillow py-lxml
RUN apk --update --upgrade add gcc musl-dev jpeg-dev zlib-dev libffi-dev cairo-dev pango-dev gdk-pixbuf-dev

RUN pip3 install weasyprint gunicorn flask flask-cors

RUN mkdir /myapp
WORKDIR /myapp
ADD ./wsgi.py /myapp
RUN mkdir /root/.fonts
# ADD ./fonts/* /root/.fonts/

CMD gunicorn --bind 0.0.0.0:5001 wsgi:app
