class Customer:
    def __init__(self, cid, n):
        self.customer_id = cid
        self.name = n


class Order:
    def __init__(self, oid, cid, od, ot):
        self.order_id = oid
        self.customer_id = cid
        self.order_date = od
        self.order_total = ot


class Profile:
    def __init__(self, a, b, c, d, e, f):
        self.id_ = a
        self.login = b
        self.name = c
        self.Followers = d
        self.Following = e
        self.Posts = f


class Post:
    def __init__(self, a, b, c, d):
        self.id_ = a
        self.login = b
        self.time = c
        self.Content = d


customers = []
customers.append(Customer(1, "Jane Doe"))
customers.append(Customer(2, "John Doe"))
customers.append(Customer(3, "Jane Smith"))
customers.append(Customer(4, "John Smith"))
customers.append(Customer(5, "Jane Jones"))
customers.append(Customer(6, "John Jones"))

orders = []
orders.append(Order(1001, 2, "10/10/09", 250.85))
orders.append(Order(1002, 2, "2/21/10", 125.89))
orders.append(Order(1003, 3, "11/15/09", 1567.99))
orders.append(Order(1004, 4, "11/22/09", 180.92))
orders.append(Order(1005, 4, "13/11/10", 565.00))
orders.append(Order(1006, 6, "11/22/09", 25.00))
orders.append(Order(1007, 6, "10/08/09", 85.00))
orders.append(Order(1008, 6, "12/29/09", 109.12))

profiles = []
profiles.append(Profile(1, 'login1', 'Mike', [3], [1], []))
profiles.append(Profile(2, 'login2', 'Tim', [2], [3], [1]))

posts = []
posts.append(Post(1, 'login2', '12/21/11', ['Post content']))
