from flask import Flask, render_template
import pymysql
app = Flask(__name__)


conn = pymysql.connect(host= "localhost",
                  user="root",
                  passwd="samudra",
                  db="project_final")

my_cursor = conn.cursor()


@app.route('/')
def home():
    # return 'Welcome to Up Work'
    return render_template('index.html')


@app.route('/popular', methods = ['POST'])
def popular():

  
    my_cursor.execute("""select * from project p where  p.project_status = 3 and p.owner_id =   14""")
    query1 = my_cursor.fetchall()

    my_cursor.execute("""select avg(rating), review_to from review r where r.review_to = 26""")
    query2  = my_cursor.fetchall()

    my_cursor.execute("""select m.message_content from message m where m.proposal_id = 11""")
    query3  = my_cursor.fetchall()

    my_cursor.execute("""select  count(u.user_id) from user u where u.is_freelancer = 1 and u.is_owner = 1""")
    query4  = my_cursor.fetchall()

    

    return render_template('result.html', result1=query1, result2 = query2, result3  = query3, result4 = query4)


if __name__ == '__main__':
    app.run()
