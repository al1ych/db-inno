import redis
from faker import Faker
from random import randint


def dict_to_redis_hset(r, hkey, dict_to_store):
    return all([r.hset(hkey, k, v) for k, v in dict_to_store.items()])


fake = Faker()

r = redis.Redis(
    host='redis-17725.c262.us-east-1-3.ec2.cloud.redislabs.com',
    port="17725",
    password='8r0tUSE3Re1Rl4jzP1idIIJJxlOHrSEv')

# access info on user: 'id_of_user user'
# post is time and user key

for i in range(10):
    data = {
        'login': fake.first_name(),
        'name': fake.name(),
        'followers': randint(1, 100),
        'following': randint(1, 100),
        'posts': ''
    }
    dict_to_redis_hset(r, str(i) + ' user', data)

# we create a new post, create new hash pair of key = 'number_of_post post'
# insert into user's dict number_of_post in field posts

for i in range(10):
    data = {
        'time': fake.date(),
        'user': str(randint(0, 10)) + ' user',
    }
    dict_to_redis_hset(r, str(i) + ' post', data)
