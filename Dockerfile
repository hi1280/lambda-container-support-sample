FROM amazon/aws-lambda-nodejs:14
COPY app.js package*.json ./
RUN npm install --production
CMD [ "app.handler" ]