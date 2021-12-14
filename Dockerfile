FROM node:17.0.1-alpine3.12

WORKDIR /usr/src/app

ENV NODE_ENV production

# Install Node.js dependencies
COPY src/ /usr/src/app
COPY yarn.lock /usr/src/app/
COPY package.json /usr/src/app/

RUN yarn install --frozen-lockfile --only=production

EXPOSE 80
CMD ["node", "index.js"]
