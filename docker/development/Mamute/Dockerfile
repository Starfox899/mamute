FROM java:7-jdk
MAINTAINER openabstract@gmail.com

RUN apt-get update && apt-get -y upgrade

# 1. Install node and npm
RUN apt-get -y install npm maven rsync

# 1.1. Create prepared maven repository to save download capacity
# RUN mkdir -p /root/.m2/repository
# ADD maven-repo.tar.gz /root/.m2/repository/

# 2. Clone the repository from github
WORKDIR /build
RUN git clone https://github.com/starfox899/mamute.git 
WORKDIR /build/mamute
RUN git checkout customized_v1.4.x 

# 3. Run npm install
RUN npm install

# 4. Run npm install -g grunt-cli
RUN npm install -g grunt-cli

# solve https://github.com/nodejs/node-v0.x-archive/issues/3911
RUN ln -s /usr/bin/nodejs /usr/bin/node

# 5. Run ./scripts/mvn-package.sh
#RUN mvn clean package 
RUN mvn clean package -DskipTests


#### From here we follow https://github.com/caelum/mamute/blob/master/docker/production/Mamute/Dockerfile

ENV VERSION=1.4.0 USER=mamute PASSWORD=Shei6cea DB=db/mamute_development

RUN mkdir /mamute
WORKDIR /mamute
RUN unzip /build/mamute/target/mamute-${VERSION}.war 

ADD ./development.properties /mamute/WEB-INF/classes/development.properties

RUN sed -i -e "s?>root<?>$USER<?g" /mamute/WEB-INF/classes/development/hibernate.cfg.xml && \
    sed -i -e "s?><?>$PASSWORD<?g" WEB-INF/classes/development/hibernate.cfg.xml && \
    sed -i -e "s?localhost/mamute_development?$DB?g" WEB-INF/classes/development/hibernate.cfg.xml

RUN chmod +x run.sh

EXPOSE 8080

# Wait for intial Database init --> TODO: Find a better way to wait for the DB
CMD sleep 15 && VRAPTOR_ENV=development ./run.sh
