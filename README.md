# README


For installation

* Install chrome driver:

      sudo npm -g install chromedriver

* Bundle

* Run migrations

* rails s


Examples:

* User creation

   Open a rails console and type

      $> User.create(email: "your-email", password: "your-password")

   Copy your token for later use

*  Api usage

   Endpoints:

        * http://localhost/tasks

           Headers:

               - Authorization     Token token=your-user-token

            Method

                - GET

        * http://localhost/tasks

            Headers:

               - Authorization     Token token=your-user-token

            Method

                - POST

             Params:

                - task[description]
                - task[website]


        * http://localhost/tasks/:id

           Headers:

               - Authorization     Token token=your-user-token

            Method

                - GET

        * http://localhost/tasks/:id

           Headers:

               - Authorization     Token token=your-user-token

            Method

                - PATCH/PUT

             Params:

                - task[description]
                - task[website]
                - task[status]


        * http://localhost/tasks/:id

           Headers:

               - Authorization     Token token=your-user-token

            Method

                - DELETE

