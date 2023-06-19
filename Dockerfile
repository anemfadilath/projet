FROM node:18-alpine as base

WORKDIR /src
COPY package*.json /
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

FROM base as production
ENV NODE_ENV=production
RUN npm ci
COPY . /
CMD ["node", "bin/www"]

FROM base as dev
ENV NODE_ENV=development
RUN npm install -g nodemon && npm install
COPY . /
CMD ["nodemon", "bin/www"]