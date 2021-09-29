'''
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="mysql",
  database="pythonDatabase"
)
mycursor = mydb.cursor()

mycursor.execute("CREATE TABLE customers (name VARCHAR(255), id INT, PRIMARY KEY(id))")
'''
import mysql.connector
from flask import Flask, redirect, url_for, request,render_template

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="mysql",
  database="pythonDatabase"
)
mycursor = mydb.cursor()
app=Flask(__name__,template_folder='template')

@app.route('/')
def hello_name():
   return render_template('index.html')

@app.route('/addcustomer',methods = ['POST', 'GET'])
def addcustomer():
   if request.method == 'POST': ##check if there is post data
      name = request.form['name']
      id = request.form['id']
      sql = "INSERT INTO customers (name, id) VALUES (%s, %s)"
      val = (name,id)
      mycursor.execute(sql, val)
      mydb.commit()   
      return render_template('index.html')
   else:
      return render_template('addcustomer.html')

@app.route('/viewcustomer',methods = ['POST', 'GET'])
def viewcustomer():
   if request.method == 'POST':
      return render_template('index.html')
   else:
      mycursor.execute("SELECT * FROM customers")
      row_headers=[x[0] for x in mycursor.description] #this will extract row headers
      myresult = mycursor.fetchall()
      data={
         'message':"data retrieved",
         'rec':myresult,
         'header':row_headers
      }
      return render_template('viewcustomer.html',data=data)

@app.route('/updatecustomer', methods = ['POST', 'GET'] )
def updatecustomer():
    if request.method == 'POST':
        old_id = request.form['oldid']
        id = request.form['newid']
        sql = "UPDATE customers SET id = %s WHERE id = %s"
        val = (id,old_id)
        mycursor.execute(sql, val)
        old_name = request.form['oldname']
        new_name = request.form['newname']
        sql_name = "UPDATE customers SET name = %s WHERE name = %s"
        val_name = (new_name,old_name)
        mycursor.execute(sql_name, val_name)
        mydb.commit()   
        mycursor.execute("SELECT * FROM customers")
        row_headers=[x[0] for x in mycursor.description] 
        myresult = mycursor.fetchall()
        data={
           'message':"data retrieved",
           'rec':myresult,
           'header':row_headers
        }
        return render_template('viewcustomer.html',data=data)
    else:
          return render_template('updatecustomer.html')
      
@app.route('/deletecustomer', methods = ['POST', 'GET'] )
def deletecustomer():
    if request.method == 'POST':
        id = request.form['id']
        sql = "DELETE FROM customers WHERE id = %s"
        val = (id, )
        mycursor.execute(sql, val)
        
        mydb.commit()   
        mycursor.execute("SELECT * FROM customers")
        row_headers=[x[0] for x in mycursor.description] 
        myresult = mycursor.fetchall()
        data={
           'message':"data retrieved",
           'rec':myresult,
           'header':row_headers
        }
        return render_template('viewcustomer.html',data=data)
    else:
          return render_template('deletecustomer.html')
if __name__ == '__main__':
   app.run()

