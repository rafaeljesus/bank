FROM iron/ruby

ENV APP_NAME bank

WORKDIR /usr/$APP_NAME

ADD . /usr/$APP_NAME

ENTRYPOINT ["bundle", "exec", "rackup"]
