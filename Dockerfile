FROM node:18

WORKDIR /app

COPY . .

RUN corepack enable
RUN yarn install
RUN yarn build

EXPOSE 3000

CMD ["yarn", "start"]
