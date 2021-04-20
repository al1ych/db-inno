import redis
from data import customers
from data import orders
from data import profiles
from data import posts


r = redis.Redis(
    host='redis-17725.c262.us-east-1-3.ec2.cloud.redislabs.com',
    port="17725",
    password='8r0tUSE3Re1Rl4jzP1idIIJJxlOHrSEv')

for i in range(len(customers)):
    r.hset('Customers', str(i), customers[i].name)
print(r.hgetall('Customers'))

for i in range(len(orders)):
    r.hset('Orders', str(orders[i].order_id),
           str(orders[i].customer_id) + ' ' + orders[i].order_date + ' ' + str(orders[i].order_total))
print(r.hgetall('Orders'))

for i in range(len(profiles)):
    r.hset('Profiles', str(profiles[i].id_),
           profiles[i].login + ' ' + profiles[i].name + ' ' + str(profiles[i].Followers) + ' ' + str(
               profiles[i].Following) + ' ' + str(profiles[i].Posts))
print(r.hgetall('Profiles'))

for i in range(len(posts)):
    r.hset('Posts', str(posts[i].id_), posts[i].login + ' ' + posts[i].time + ' ' + str(posts[i].Content))
print(r.hgetall('Posts'))

# output

# {b'0': b'Jane Doe', b'1': b'John Doe', b'2': b'Jane Smith', b'3': b'John Smith', b'4': b'Jane Jones', b'5': b'John
# Jones', b'6': b'Dawn Gutierrez', b'7': b'Lisa Watson', b'8': b'Sheryl Nelson', b'9': b'Patrick Smith'}
#
# {b'1000':
# b'4 some_date 788', b'1001': b'2 10/10/09 250.85', b'1002': b'2 2/21/10 125.89', b'1003': b'3 11/15/09 1567.99',
# b'1004': b'4 11/22/09 180.92', b'1005': b'4 13/11/10 565.0', b'1006': b'6 11/22/09 25.0', b'1007': b'6 10/08/09
# 85.0', b'1008': b'6 12/29/09 109.12', b'1009': b'8 some_date 739'}
#
# {b'1': b'login1 Mike [3] [1] []', b'2': b'login2
# Tim [2] [3] [1]'}
#
# {b'1': b"login2 12/21/11 ['Post content']"}
