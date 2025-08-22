# AI代码生成专题指南 - 民航软件开发实战

## 概述

AI代码生成是现代软件开发中最重要的辅助功能之一。本指南基于民航行业的实际需求，详细介绍四个核心代码生成场景的使用方法。

## 代码生成场景全景

```
代码生成
├── 业务逻辑实现    （核心业务规则转代码）
├── API接口开发     （接口设计与实现）
├── 数据库操作      （数据访问层代码）
└── 算法实现        （复杂算法逻辑）
```

---

## 场景一：业务逻辑实现

### 🎯 场景定义
将复杂的民航业务规则转换为可执行的代码，包括票价计算、航班调度、延误补偿等核心业务逻辑。

### 🧠 使用模式与思路

#### 核心思路：注释驱动开发
1. **先写详细注释**：用自然语言描述业务规则
2. **结构化表达**：按照条件、计算、返回的逻辑组织
3. **AI补全实现**：基于注释让AI生成具体代码
4. **迭代优化**：根据生成结果调整注释和代码

#### 最佳实践模式
```python
# 模式1：规则引擎模式
def business_rule_function():
    """
    1. 详细描述业务规则
    2. 列出所有判断条件
    3. 说明计算公式
    4. 明确返回格式
    """
    # AI会基于注释生成实现

# 模式2：分步骤模式
def complex_business_logic():
    # 步骤1：输入验证
    # 步骤2：规则判断
    # 步骤3：计算处理
    # 步骤4：结果返回
    pass
```

### 📝 案例实践

#### 案例1：航班延误补偿计算

**业务需求**：根据民航局规定计算延误补偿金额

```python
def calculate_delay_compensation(delay_minutes, ticket_price, cabin_class, delay_reason):
    """
    计算航班延误补偿金额
    
    补偿规则（民航局规定）：
    - 承运人原因延误4小时以上：200-400元或全额退票
    - 承运人原因延误2-4小时：100-200元
    - 承运人原因延误1-2小时：50-100元  
    - 非承运人原因（天气、流控）：无现金补偿，提供服务
    - 舱位影响：头等舱、商务舱补偿翻倍
    """
    
    # AI根据注释生成的实现：
    if delay_reason not in ["承运人", "机械故障", "机组原因"]:
        return {"compensation": 0, "reason": "非承运人原因，提供餐食住宿服务"}
    
    # 基础补偿金额
    if delay_minutes < 60:
        base_amount = 0
    elif delay_minutes < 120:
        base_amount = 50
    elif delay_minutes < 240:
        base_amount = 100
    else:
        base_amount = max(200, min(400, ticket_price * 0.3))
    
    # 舱位加成
    if cabin_class in ["头等舱", "商务舱"]:
        base_amount *= 2
    
    return {
        "compensation": base_amount,
        "reason": f"承运人原因延误{delay_minutes}分钟",
        "additional_service": "提供餐食和住宿安排"
    }
```

#### 案例2：机票退改签费用计算

```python
def calculate_refund_fee(booking_info, operation_type, operation_time):
    """
    计算机票退改签手续费
    
    规则说明：
    - 起飞前24小时以上：退票5%，改签免费
    - 起飞前2-24小时：退票10%，改签50元
    - 起飞前2小时内：退票20%，改签100元
    - 起飞后：不退不改
    - 特价票：起飞前退票50%，不允许改签
    - 全价票：退票费用减半
    """
    
    # AI生成的实现逻辑
    import datetime
    
    departure_time = datetime.datetime.fromisoformat(booking_info['departure_time'])
    time_diff = (departure_time - operation_time).total_seconds() / 3600  # 小时差
    
    if time_diff <= 0:
        return {"allowed": False, "reason": "起飞后不允许退改"}
    
    ticket_price = booking_info['price']
    ticket_type = booking_info['type']  # 'full', 'discount', 'special'
    
    if operation_type == "退票":
        if ticket_type == "special":
            fee_rate = 0.5
        elif time_diff >= 24:
            fee_rate = 0.05 if ticket_type == "full" else 0.025
        elif time_diff >= 2:
            fee_rate = 0.10 if ticket_type == "full" else 0.05
        else:
            fee_rate = 0.20 if ticket_type == "full" else 0.10
            
        return {
            "allowed": True,
            "fee": ticket_price * fee_rate,
            "refund": ticket_price * (1 - fee_rate)
        }
    
    elif operation_type == "改签":
        if ticket_type == "special":
            return {"allowed": False, "reason": "特价票不允许改签"}
        
        if time_diff >= 24:
            fee = 0
        elif time_diff >= 2:
            fee = 50
        else:
            fee = 100
            
        return {"allowed": True, "fee": fee}
```

---

## 场景二：API接口开发

### 🎯 场景定义
快速生成RESTful API接口，包括路由定义、请求处理、响应格式化等完整的接口代码。

### 🧠 使用模式与思路

#### 核心思路：接口优先设计
1. **定义接口规范**：先明确API的输入输出格式
2. **描述业务逻辑**：在注释中详细说明处理流程
3. **AI生成框架**：让AI生成标准的API结构
4. **完善细节**：添加验证、错误处理、日志等

#### API生成模式
```python
# 模式1：Flask/FastAPI模式
@app.route('/api/flights', methods=['POST'])
def create_flight():
    """
    创建航班信息接口
    输入：航班基本信息
    输出：创建结果和航班ID
    业务逻辑：验证->保存->通知
    """
    pass

# 模式2：类型提示模式
from typing import Dict, List
from pydantic import BaseModel

def process_booking(request: BookingRequest) -> BookingResponse:
    """基于类型提示，AI会生成相应的处理逻辑"""
    pass
```

### 📝 案例实践

#### 案例1：航班查询API

```python
from flask import Flask, request, jsonify
from datetime import datetime, timedelta

app = Flask(__name__)

@app.route('/api/flights/search', methods=['GET'])
def search_flights():
    """
    航班查询接口
    
    查询参数：
    - departure: 出发城市代码 (必填)
    - arrival: 到达城市代码 (必填)  
    - date: 出发日期 YYYY-MM-DD (必填)
    - passengers: 乘客数量 (默认1)
    - cabin: 舱位类型 economy/business/first (默认economy)
    
    返回格式：
    - flights: 航班列表
    - total: 总数量
    - filters: 可用筛选条件
    """
    
    # AI生成的接口实现
    try:
        # 参数获取和验证
        departure = request.args.get('departure')
        arrival = request.args.get('arrival')
        date = request.args.get('date')
        passengers = int(request.args.get('passengers', 1))
        cabin = request.args.get('cabin', 'economy')
        
        # 输入验证
        if not all([departure, arrival, date]):
            return jsonify({
                "error": "缺少必填参数",
                "required": ["departure", "arrival", "date"]
            }), 400
        
        # 日期格式验证
        try:
            flight_date = datetime.strptime(date, '%Y-%m-%d')
        except ValueError:
            return jsonify({"error": "日期格式错误，应为YYYY-MM-DD"}), 400
        
        # 业务逻辑：查询航班
        flights = query_flights_from_database(
            departure=departure,
            arrival=arrival,
            date=flight_date,
            passengers=passengers,
            cabin=cabin
        )
        
        # 结果处理和格式化
        formatted_flights = []
        for flight in flights:
            formatted_flights.append({
                "flight_number": flight['number'],
                "departure_time": flight['dep_time'].isoformat(),
                "arrival_time": flight['arr_time'].isoformat(),
                "price": flight['price'],
                "available_seats": flight['seats'],
                "aircraft_type": flight['aircraft'],
                "duration": str(flight['duration']),
                "airline": flight['airline_name']
            })
        
        # 构建响应
        response = {
            "success": True,
            "data": {
                "flights": formatted_flights,
                "total": len(formatted_flights),
                "query": {
                    "departure": departure,
                    "arrival": arrival,
                    "date": date,
                    "passengers": passengers,
                    "cabin": cabin
                },
                "filters": {
                    "airlines": list(set(f['airline'] for f in formatted_flights)),
                    "price_range": {
                        "min": min(f['price'] for f in formatted_flights) if formatted_flights else 0,
                        "max": max(f['price'] for f in formatted_flights) if formatted_flights else 0
                    }
                }
            }
        }
        
        return jsonify(response)
        
    except Exception as e:
        return jsonify({
            "success": False,
            "error": "系统内部错误",
            "message": str(e)
        }), 500

def query_flights_from_database(departure, arrival, date, passengers, cabin):
    """
    从数据库查询航班信息
    这里AI会生成数据库查询逻辑
    """
    # AI生成的数据库查询代码
    import sqlite3
    
    conn = sqlite3.connect('flights.db')
    cursor = conn.cursor()
    
    query = """
    SELECT f.flight_number, f.departure_time, f.arrival_time, 
           p.price, f.available_seats, f.aircraft_type, a.airline_name
    FROM flights f
    JOIN prices p ON f.flight_id = p.flight_id
    JOIN airlines a ON f.airline_id = a.airline_id
    WHERE f.departure_airport = ? 
      AND f.arrival_airport = ?
      AND DATE(f.departure_time) = DATE(?)
      AND f.available_seats >= ?
      AND p.cabin_class = ?
    ORDER BY f.departure_time
    """
    
    cursor.execute(query, (departure, arrival, date.strftime('%Y-%m-%d'), passengers, cabin))
    results = cursor.fetchall()
    conn.close()
    
    return results
```

#### 案例2：订票接口

```python
@app.route('/api/bookings', methods=['POST'])
def create_booking():
    """
    创建订票接口
    
    请求格式：
    {
        "flight_id": "CZ3101",
        "passengers": [
            {
                "name": "张三",
                "id_type": "身份证",
                "id_number": "110101199001011234",
                "phone": "13800138000"
            }
        ],
        "contact": {
            "name": "张三", 
            "phone": "13800138000",
            "email": "zhang@example.com"
        },
        "seat_preferences": ["窗口", "过道"]
    }
    
    返回：预订确认信息和支付链接
    """
    
    # AI生成的订票接口实现
    try:
        data = request.get_json()
        
        # 数据验证
        required_fields = ['flight_id', 'passengers', 'contact']
        for field in required_fields:
            if field not in data:
                return jsonify({"error": f"缺少字段: {field}"}), 400
        
        # 航班可用性检查
        flight_info = check_flight_availability(data['flight_id'], len(data['passengers']))
        if not flight_info:
            return jsonify({"error": "航班不存在或座位不足"}), 400
        
        # 乘客信息验证
        for passenger in data['passengers']:
            if not validate_passenger_info(passenger):
                return jsonify({"error": f"乘客信息不完整: {passenger.get('name', '未知')}"}), 400
        
        # 创建订单
        booking = {
            "booking_id": generate_booking_id(),
            "flight_id": data['flight_id'],
            "passengers": data['passengers'],
            "contact": data['contact'],
            "status": "待支付",
            "total_price": flight_info['price'] * len(data['passengers']),
            "created_at": datetime.now().isoformat(),
            "expires_at": (datetime.now() + timedelta(minutes=30)).isoformat()
        }
        
        # 保存到数据库
        booking_id = save_booking_to_database(booking)
        
        # 生成支付链接
        payment_url = generate_payment_link(booking_id, booking['total_price'])
        
        return jsonify({
            "success": True,
            "data": {
                "booking_id": booking_id,
                "flight_info": flight_info,
                "total_price": booking['total_price'],
                "payment_url": payment_url,
                "expires_at": booking['expires_at']
            }
        })
        
    except Exception as e:
        return jsonify({"error": str(e)}), 500
```

---

## 场景三：数据库操作

### 🎯 场景定义
生成数据访问层代码，包括CRUD操作、复杂查询、数据库连接管理等。

### 🧠 使用模式与思路

#### 核心思路：模型驱动开发
1. **定义数据模型**：先创建清晰的数据结构
2. **描述操作需求**：明确要实现的数据操作
3. **AI生成代码**：基于模型自动生成CRUD
4. **优化性能**：添加索引、缓存、连接池等

#### 数据库操作模式
```python
# 模式1：ORM模式（SQLAlchemy）
class Flight(db.Model):
    """航班模型，AI会基于字段生成相应的查询方法"""
    id = db.Column(db.Integer, primary_key=True)
    flight_number = db.Column(db.String(10), nullable=False)
    # 其他字段...

# 模式2：原生SQL模式
def get_flights_by_route(departure, arrival):
    """
    查询特定航线的航班
    使用原生SQL优化查询性能
    """
    sql = "SELECT ... FROM flights WHERE ..."
    # AI会生成具体的SQL语句
```

### 📝 案例实践

#### 案例1：航班数据管理

```python
from sqlalchemy import create_engine, Column, Integer, String, DateTime, Float
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from datetime import datetime, timedelta

Base = declarative_base()

class Flight(Base):
    """
    航班信息模型
    包含航班基本信息、时刻、价格等核心数据
    """
    __tablename__ = 'flights'
    
    id = Column(Integer, primary_key=True)
    flight_number = Column(String(10), nullable=False, index=True)
    airline_code = Column(String(3), nullable=False)
    departure_airport = Column(String(3), nullable=False, index=True)
    arrival_airport = Column(String(3), nullable=False, index=True)
    departure_time = Column(DateTime, nullable=False, index=True)
    arrival_time = Column(DateTime, nullable=False)
    aircraft_type = Column(String(10), nullable=False)
    total_seats = Column(Integer, nullable=False)
    available_seats = Column(Integer, nullable=False)
    base_price = Column(Float, nullable=False)
    status = Column(String(20), default='scheduled')  # scheduled, delayed, cancelled
    created_at = Column(DateTime, default=datetime.utcnow)

class FlightRepository:
    """
    航班数据访问层
    提供所有航班相关的数据库操作
    """
    
    def __init__(self, db_session):
        self.session = db_session
    
    def create_flight(self, flight_data):
        """
        创建新航班
        输入航班基本信息，返回创建的航班对象
        """
        # AI生成的创建逻辑
        flight = Flight(
            flight_number=flight_data['flight_number'],
            airline_code=flight_data['airline_code'],
            departure_airport=flight_data['departure_airport'],
            arrival_airport=flight_data['arrival_airport'],
            departure_time=flight_data['departure_time'],
            arrival_time=flight_data['arrival_time'],
            aircraft_type=flight_data['aircraft_type'],
            total_seats=flight_data['total_seats'],
            available_seats=flight_data['total_seats'],  # 初始可用座位等于总座位
            base_price=flight_data['base_price']
        )
        
        try:
            self.session.add(flight)
            self.session.commit()
            return flight
        except Exception as e:
            self.session.rollback()
            raise Exception(f"创建航班失败: {str(e)}")
    
    def search_flights(self, departure, arrival, date, passengers=1):
        """
        搜索航班
        根据出发地、目的地、日期查询可用航班
        """
        # AI生成的复杂查询逻辑
        query = self.session.query(Flight).filter(
            Flight.departure_airport == departure,
            Flight.arrival_airport == arrival,
            Flight.departure_time.between(
                datetime.combine(date, datetime.min.time()),
                datetime.combine(date, datetime.max.time())
            ),
            Flight.available_seats >= passengers,
            Flight.status == 'scheduled'
        ).order_by(Flight.departure_time)
        
        return query.all()
    
    def update_seat_availability(self, flight_id, seat_change):
        """
        更新座位可用性
        用于订票和退票时更新可用座位数
        """
        # AI生成的原子更新操作
        flight = self.session.query(Flight).filter_by(id=flight_id).first()
        if not flight:
            raise Exception("航班不存在")
        
        new_available = flight.available_seats + seat_change
        if new_available < 0:
            raise Exception("可用座位不足")
        if new_available > flight.total_seats:
            raise Exception("可用座位超过总座位数")
        
        flight.available_seats = new_available
        self.session.commit()
        
        return flight
    
    def get_flight_statistics(self, start_date, end_date):
        """
        获取航班统计信息
        分析指定时间段内的航班运营数据
        """
        # AI生成的统计查询
        from sqlalchemy import func
        
        stats = self.session.query(
            func.count(Flight.id).label('total_flights'),
            func.avg(Flight.available_seats * 100.0 / Flight.total_seats).label('avg_availability'),
            func.sum(Flight.total_seats - Flight.available_seats).label('total_booked'),
            Flight.departure_airport.label('airport')
        ).filter(
            Flight.departure_time.between(start_date, end_date)
        ).group_by(Flight.departure_airport).all()
        
        return [
            {
                'airport': stat.airport,
                'total_flights': stat.total_flights,
                'average_availability': round(stat.avg_availability, 2),
                'total_bookings': stat.total_booked
            }
            for stat in stats
        ]
```

#### 案例2：订单数据管理

```python
class Booking(Base):
    """
    订单模型
    记录乘客订票信息和订单状态
    """
    __tablename__ = 'bookings'
    
    id = Column(Integer, primary_key=True)
    booking_number = Column(String(20), unique=True, nullable=False)
    flight_id = Column(Integer, nullable=False, index=True)
    passenger_count = Column(Integer, nullable=False)
    total_price = Column(Float, nullable=False)
    contact_name = Column(String(100), nullable=False)
    contact_phone = Column(String(20), nullable=False)
    contact_email = Column(String(100))
    status = Column(String(20), default='pending')  # pending, confirmed, cancelled
    created_at = Column(DateTime, default=datetime.utcnow)
    expires_at = Column(DateTime)

class BookingRepository:
    """订单数据访问层"""
    
    def __init__(self, db_session):
        self.session = db_session
    
    def create_booking(self, booking_data):
        """
        创建订单
        包含事务处理，确保数据一致性
        """
        # AI生成的事务处理逻辑
        try:
            # 开始事务
            booking = Booking(
                booking_number=self.generate_booking_number(),
                flight_id=booking_data['flight_id'],
                passenger_count=len(booking_data['passengers']),
                total_price=booking_data['total_price'],
                contact_name=booking_data['contact']['name'],
                contact_phone=booking_data['contact']['phone'],
                contact_email=booking_data['contact'].get('email'),
                expires_at=datetime.utcnow() + timedelta(minutes=30)
            )
            
            # 保存订单
            self.session.add(booking)
            self.session.flush()  # 获取ID但不提交
            
            # 更新航班座位
            flight_repo = FlightRepository(self.session)
            flight_repo.update_seat_availability(
                booking_data['flight_id'], 
                -len(booking_data['passengers'])
            )
            
            # 保存乘客信息
            for passenger in booking_data['passengers']:
                passenger_record = Passenger(
                    booking_id=booking.id,
                    name=passenger['name'],
                    id_type=passenger['id_type'],
                    id_number=passenger['id_number'],
                    phone=passenger.get('phone')
                )
                self.session.add(passenger_record)
            
            # 提交事务
            self.session.commit()
            return booking
            
        except Exception as e:
            self.session.rollback()
            raise Exception(f"创建订单失败: {str(e)}")
    
    def get_expiring_bookings(self):
        """
        查询即将过期的未支付订单
        用于定时清理任务
        """
        # AI生成的定时任务查询
        expiring_time = datetime.utcnow() + timedelta(minutes=5)
        
        return self.session.query(Booking).filter(
            Booking.status == 'pending',
            Booking.expires_at <= expiring_time
        ).all()
    
    def generate_booking_number(self):
        """生成唯一订单号"""
        import random
        import string
        
        while True:
            # 格式：日期 + 4位随机字母数字
            date_part = datetime.now().strftime('%Y%m%d')
            random_part = ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))
            booking_number = f"CA{date_part}{random_part}"
            
            # 检查是否已存在
            existing = self.session.query(Booking).filter_by(
                booking_number=booking_number
            ).first()
            
            if not existing:
                return booking_number
```

---

## 场景四：算法实现

### 🎯 场景定义
将复杂的算法逻辑转换为代码实现，包括优化算法、调度算法、机器学习算法等。

### 🧠 使用模式与思路

#### 核心思路：算法伪代码转换
1. **明确算法目标**：详细描述要解决的问题
2. **设计算法步骤**：用伪代码或自然语言描述流程
3. **AI实现代码**：让AI将算法逻辑转换为具体实现
4. **性能优化**：分析复杂度，优化关键路径

#### 算法实现模式
```python
# 模式1：分治算法模式
def solve_problem(data):
    """
    问题描述：...
    算法思路：分治法
    1. 分解子问题
    2. 递归求解  
    3. 合并结果
    """
    # AI会生成分治算法实现

# 模式2：动态规划模式
def optimization_problem(params):
    """
    优化问题描述：...
    状态定义：dp[i][j] 表示...
    状态转移：dp[i][j] = ...
    """
    # AI会生成DP实现
```

### 📝 案例实践

#### 案例1：航班时刻优化分配

```python
import heapq
from typing import List, Dict, Tuple
from dataclasses import dataclass
from datetime import datetime, timedelta

@dataclass
class SlotRequest:
    """时刻申请"""
    airline: str
    flight_number: str
    preferred_time: datetime
    flexibility: int  # 可接受的时间偏移（分钟）
    priority: int     # 优先级（1-5，5最高）
    aircraft_type: str
    passenger_count: int

@dataclass  
class TimeSlot:
    """时刻槽"""
    time: datetime
    capacity: int     # 容量（架次）
    available: int    # 剩余容量
    weather_impact: float  # 天气影响因子（0-1）

class FlightSlotOptimizer:
    """
    航班时刻优化分配算法
    
    目标：在满足机场容量约束的前提下，最大化整体满意度
    约束：
    1. 机场容量限制
    2. 天气影响
    3. 航班最小间隔
    4. 优先级权重
    
    算法：基于优先队列的贪心算法 + 局部优化
    """
    
    def __init__(self, airport_capacity: Dict[str, int], min_interval: int = 2):
        self.airport_capacity = airport_capacity  # 每小时容量
        self.min_interval = min_interval  # 最小间隔（分钟）
        
    def optimize_allocation(self, requests: List[SlotRequest], 
                          available_slots: List[TimeSlot]) -> Dict:
        """
        优化时刻分配
        
        算法步骤：
        1. 构建优先队列（按优先级和偏好时间排序）
        2. 贪心分配最优时刻
        3. 冲突解决和局部调整
        4. 评估分配结果
        """
        
        # AI生成的算法实现
        
        # 步骤1：按优先级排序请求
        sorted_requests = sorted(requests, key=self._calculate_priority, reverse=True)
        
        # 步骤2：初始化分配结果
        allocation = {}
        slot_usage = {slot.time: 0 for slot in available_slots}
        
        # 步骤3：贪心分配
        for request in sorted_requests:
            best_slot = self._find_best_slot(request, available_slots, slot_usage)
            
            if best_slot:
                allocation[request.flight_number] = {
                    'allocated_time': best_slot.time,
                    'original_request': request.preferred_time,
                    'deviation': abs((best_slot.time - request.preferred_time).total_seconds() / 60),
                    'satisfaction': self._calculate_satisfaction(request, best_slot)
                }
                slot_usage[best_slot.time] += 1
            else:
                allocation[request.flight_number] = {
                    'allocated_time': None,
                    'status': 'rejected',
                    'reason': 'no_available_slot'
                }
        
        # 步骤4：局部优化
        optimized_allocation = self._local_optimization(allocation, requests, available_slots)
        
        # 步骤5：生成分配报告
        report = self._generate_allocation_report(optimized_allocation, requests)
        
        return {
            'allocation': optimized_allocation,
            'statistics': report,
            'optimization_log': self._get_optimization_log()
        }
    
    def _calculate_priority(self, request: SlotRequest) -> float:
        """
        计算请求的综合优先级
        考虑：基础优先级、乘客数量、航司等级
        """
        # AI生成的优先级计算逻辑
        base_score = request.priority * 100
        passenger_bonus = min(request.passenger_count / 10, 50)  # 乘客数奖励
        flexibility_penalty = request.flexibility * 0.1  # 灵活性越高，优先级略降
        
        return base_score + passenger_bonus - flexibility_penalty
    
    def _find_best_slot(self, request: SlotRequest, 
                       slots: List[TimeSlot], 
                       usage: Dict) -> TimeSlot:
        """
        为请求找到最佳时刻槽
        评估标准：时间偏差 + 容量利用 + 天气影响
        """
        # AI生成的最佳匹配算法
        best_slot = None
        best_score = float('-inf')
        
        for slot in slots:
            # 检查容量约束
            if usage[slot.time] >= slot.available:
                continue
            
            # 计算时间偏差
            time_diff = abs((slot.time - request.preferred_time).total_seconds() / 60)
            if time_diff > request.flexibility:
                continue
            
            # 计算综合得分
            time_score = max(0, 100 - time_diff)  # 时间匹配度
            capacity_score = (slot.available - usage[slot.time]) * 10  # 容量充裕度
            weather_score = slot.weather_impact * 50  # 天气条件
            
            total_score = time_score + capacity_score + weather_score
            
            if total_score > best_score:
                best_score = total_score
                best_slot = slot
        
        return best_slot
    
    def _local_optimization(self, allocation: Dict, 
                          requests: List[SlotRequest],
                          slots: List[TimeSlot]) -> Dict:
        """
        局部优化：通过交换和调整提升整体满意度
        """
        # AI生成的局部优化算法
        optimized = allocation.copy()
        improved = True
        iterations = 0
        max_iterations = 10
        
        while improved and iterations < max_iterations:
            improved = False
            iterations += 1
            
            # 尝试两两交换
            allocated_flights = [f for f, a in optimized.items() 
                               if a.get('allocated_time') is not None]
            
            for i in range(len(allocated_flights)):
                for j in range(i + 1, len(allocated_flights)):
                    flight1, flight2 = allocated_flights[i], allocated_flights[j]
                    
                    # 尝试交换时刻
                    if self._try_swap(flight1, flight2, optimized, requests):
                        improved = True
                        break
                        
                if improved:
                    break
        
        return optimized
    
    def _try_swap(self, flight1: str, flight2: str, 
                  allocation: Dict, requests: List[SlotRequest]) -> bool:
        """
        尝试交换两个航班的时刻，如果能提升整体满意度则执行
        """
        # AI生成的交换逻辑
        alloc1 = allocation[flight1]
        alloc2 = allocation[flight2]
        
        # 计算交换前的满意度
        old_satisfaction = alloc1['satisfaction'] + alloc2['satisfaction']
        
        # 计算交换后的满意度
        req1 = next(r for r in requests if r.flight_number == flight1)
        req2 = next(r for r in requests if r.flight_number == flight2)
        
        new_sat1 = self._calculate_satisfaction_for_time(req1, alloc2['allocated_time'])
        new_sat2 = self._calculate_satisfaction_for_time(req2, alloc1['allocated_time'])
        new_satisfaction = new_sat1 + new_sat2
        
        # 如果有改善则执行交换
        if new_satisfaction > old_satisfaction:
            allocation[flight1]['allocated_time'] = alloc2['allocated_time']
            allocation[flight1]['satisfaction'] = new_sat1
            allocation[flight2]['allocated_time'] = alloc1['allocated_time'] 
            allocation[flight2]['satisfaction'] = new_sat2
            return True
        
        return False
    
    def _calculate_satisfaction(self, request: SlotRequest, slot: TimeSlot) -> float:
        """计算分配满意度"""
        time_diff = abs((slot.time - request.preferred_time).total_seconds() / 60)
        satisfaction = max(0, 100 - (time_diff / request.flexibility) * 100)
        return satisfaction * slot.weather_impact
    
    def _generate_allocation_report(self, allocation: Dict, 
                                  requests: List[SlotRequest]) -> Dict:
        """生成分配统计报告"""
        # AI生成的报告统计逻辑
        total_requests = len(requests)
        allocated = sum(1 for a in allocation.values() if a.get('allocated_time'))
        rejected = total_requests - allocated
        
        if allocated > 0:
            avg_satisfaction = sum(a.get('satisfaction', 0) for a in allocation.values()) / allocated
            avg_deviation = sum(a.get('deviation', 0) for a in allocation.values() if a.get('deviation')) / allocated
        else:
            avg_satisfaction = 0
            avg_deviation = 0
        
        return {
            'total_requests': total_requests,
            'allocated': allocated,
            'rejected': rejected,
            'allocation_rate': allocated / total_requests * 100,
            'average_satisfaction': round(avg_satisfaction, 2),
            'average_deviation_minutes': round(avg_deviation, 2)
        }
```

#### 案例2：航线网络优化

```python
import networkx as nx
from typing import Dict, List, Set, Tuple
import numpy as np

class RouteNetworkOptimizer:
    """
    航线网络优化算法
    
    目标：在给定约束下设计最优航线网络
    - 最大化收益
    - 最小化运营成本
    - 满足市场需求
    - 考虑竞争因素
    
    算法：遗传算法 + 网络流优化
    """
    
    def __init__(self, airports: List[str], demand_matrix: np.ndarray, cost_matrix: np.ndarray):
        self.airports = airports
        self.demand_matrix = demand_matrix  # 需求矩阵
        self.cost_matrix = cost_matrix      # 成本矩阵
        self.graph = nx.Graph()
        
    def optimize_network(self, budget: float, max_routes: int) -> Dict:
        """
        优化航线网络
        
        算法步骤：
        1. 初始化种群（随机生成网络方案）
        2. 评估适应度（收益、成本、连通性）
        3. 选择、交叉、变异操作
        4. 迭代优化直到收敛
        """
        
        # AI生成的遗传算法实现
        population_size = 50
        generations = 100
        mutation_rate = 0.1
        
        # 初始化种群
        population = self._initialize_population(population_size, max_routes, budget)
        
        best_solution = None
        best_fitness = float('-inf')
        
        for generation in range(generations):
            # 评估适应度
            fitness_scores = [self._evaluate_fitness(individual, budget) 
                            for individual in population]
            
            # 记录最佳解
            gen_best_idx = np.argmax(fitness_scores)
            if fitness_scores[gen_best_idx] > best_fitness:
                best_fitness = fitness_scores[gen_best_idx]
                best_solution = population[gen_best_idx].copy()
            
            # 选择父代
            parents = self._selection(population, fitness_scores)
            
            # 生成下一代
            new_population = []
            for i in range(0, len(parents), 2):
                if i + 1 < len(parents):
                    child1, child2 = self._crossover(parents[i], parents[i+1])
                    child1 = self._mutate(child1, mutation_rate)
                    child2 = self._mutate(child2, mutation_rate)
                    new_population.extend([child1, child2])
            
            population = new_population
        
        # 分析最优解
        analysis = self._analyze_solution(best_solution, budget)
        
        return {
            'optimal_routes': best_solution,
            'fitness_score': best_fitness,
            'analysis': analysis,
            'network_metrics': self._calculate_network_metrics(best_solution)
        }
    
    def _initialize_population(self, size: int, max_routes: int, budget: float) -> List[Set]:
        """初始化种群 - 随机生成可行的航线网络"""
        # AI生成的种群初始化逻辑
        population = []
        
        for _ in range(size):
            routes = set()
            current_cost = 0
            
            # 随机添加航线，直到达到预算或数量限制
            available_routes = [(i, j) for i in range(len(self.airports)) 
                              for j in range(i+1, len(self.airports))]
            np.random.shuffle(available_routes)
            
            for i, j in available_routes:
                route_cost = self.cost_matrix[i][j]
                if (current_cost + route_cost <= budget and 
                    len(routes) < max_routes):
                    routes.add((i, j))
                    current_cost += route_cost
            
            population.append(routes)
        
        return population
    
    def _evaluate_fitness(self, routes: Set[Tuple], budget: float) -> float:
        """
        评估网络方案的适应度
        综合考虑收益、成本、连通性、市场覆盖
        """
        # AI生成的适应度评估逻辑
        
        # 1. 计算总收益（基于需求和航线）
        total_revenue = 0
        for i, j in routes:
            market_demand = self.demand_matrix[i][j]
            # 简化收益模型：需求 * 单价
            revenue = market_demand * self._get_ticket_price(i, j)
            total_revenue += revenue
        
        # 2. 计算总成本
        total_cost = sum(self.cost_matrix[i][j] for i, j in routes)
        
        # 3. 计算连通性奖励
        connectivity_bonus = self._calculate_connectivity(routes) * 1000
        
        # 4. 计算市场覆盖率
        covered_markets = len(routes)
        max_markets = len(self.airports) * (len(self.airports) - 1) // 2
        coverage_bonus = (covered_markets / max_markets) * 500
        
        # 5. 预算约束惩罚
        budget_penalty = max(0, total_cost - budget) * 10
        
        # 综合适应度
        fitness = (total_revenue - total_cost + connectivity_bonus + 
                  coverage_bonus - budget_penalty)
        
        return fitness
    
    def _calculate_connectivity(self, routes: Set[Tuple]) -> float:
        """计算网络连通性指标"""
        # AI生成的连通性计算
        if not routes:
            return 0
        
        # 构建图
        G = nx.Graph()
        G.add_nodes_from(range(len(self.airports)))
        G.add_edges_from(routes)
        
        # 计算连通组件
        components = list(nx.connected_components(G))
        largest_component = max(len(c) for c in components)
        
        # 连通性得分：最大连通组件的相对大小
        connectivity_score = largest_component / len(self.airports)
        
        return connectivity_score
    
    def _selection(self, population: List[Set], fitness_scores: List[float]) -> List[Set]:
        """选择操作 - 轮盘赌选择"""
        # AI生成的选择算法
        # 转换为正数（如果有负适应度）
        min_fitness = min(fitness_scores)
        if min_fitness < 0:
            adjusted_scores = [f - min_fitness + 1 for f in fitness_scores]
        else:
            adjusted_scores = fitness_scores
        
        total_fitness = sum(adjusted_scores)
        if total_fitness == 0:
            return population  # 避免除零错误
        
        selection_probs = [f / total_fitness for f in adjusted_scores]
        
        # 选择父代
        selected = []
        for _ in range(len(population)):
            idx = np.random.choice(len(population), p=selection_probs)
            selected.append(population[idx])
        
        return selected
    
    def _crossover(self, parent1: Set[Tuple], parent2: Set[Tuple]) -> Tuple[Set, Set]:
        """交叉操作 - 航线交换"""
        # AI生成的交叉算法
        child1 = parent1.copy()
        child2 = parent2.copy()
        
        # 随机选择交换比例
        if len(parent1) > 0 and len(parent2) > 0:
            # 从parent1中选择一部分给child2
            swap_size1 = np.random.randint(1, min(3, len(parent1) + 1))
            swap_routes1 = np.random.choice(list(parent1), swap_size1, replace=False)
            
            # 从parent2中选择一部分给child1  
            swap_size2 = np.random.randint(1, min(3, len(parent2) + 1))
            swap_routes2 = np.random.choice(list(parent2), swap_size2, replace=False)
            
            # 执行交换
            for route in swap_routes1:
                child1.discard(route)
                child2.add(route)
            
            for route in swap_routes2:
                child2.discard(route)
                child1.add(route)
        
        return child1, child2
    
    def _mutate(self, individual: Set[Tuple], mutation_rate: float) -> Set[Tuple]:
        """变异操作 - 随机添加或删除航线"""
        # AI生成的变异算法
        if np.random.random() < mutation_rate:
            # 随机选择变异类型
            if len(individual) > 0 and np.random.random() < 0.5:
                # 删除一条航线
                route_to_remove = np.random.choice(list(individual))
                individual.discard(route_to_remove)
            else:
                # 添加一条航线
                all_possible = [(i, j) for i in range(len(self.airports)) 
                               for j in range(i+1, len(self.airports))]
                available = [r for r in all_possible if r not in individual]
                if available:
                    new_route = np.random.choice(len(available))
                    individual.add(available[new_route])
        
        return individual
    
    def _analyze_solution(self, solution: Set[Tuple], budget: float) -> Dict:
        """分析最优解的详细信息"""
        # AI生成的解分析逻辑
        total_cost = sum(self.cost_matrix[i][j] for i, j in solution)
        total_revenue = sum(self.demand_matrix[i][j] * self._get_ticket_price(i, j) 
                          for i, j in solution)
        
        route_details = []
        for i, j in solution:
            route_details.append({
                'route': f"{self.airports[i]} - {self.airports[j]}",
                'demand': self.demand_matrix[i][j],
                'cost': self.cost_matrix[i][j],
                'revenue': self.demand_matrix[i][j] * self._get_ticket_price(i, j),
                'profit_margin': (self.demand_matrix[i][j] * self._get_ticket_price(i, j) - 
                                self.cost_matrix[i][j]) / self.cost_matrix[i][j] * 100
            })
        
        return {
            'total_routes': len(solution),
            'total_cost': total_cost,
            'total_revenue': total_revenue,
            'net_profit': total_revenue - total_cost,
            'budget_utilization': total_cost / budget * 100,
            'route_details': sorted(route_details, key=lambda x: x['profit_margin'], reverse=True)
        }
    
    def _get_ticket_price(self, i: int, j: int) -> float:
        """获取航线票价（简化模型）"""
        # 基于距离和需求的定价模型
        base_price = 500 + self.cost_matrix[i][j] * 0.1
        demand_factor = min(2.0, self.demand_matrix[i][j] / 1000)
        return base_price * demand_factor
```

---

## 总结

本指南详细介绍了AI代码生成的四个核心场景，每个场景都包含：

1. **使用模式与思路**：核心方法论和最佳实践
2. **实战案例**：基于民航行业的具体代码示例
3. **渐进式学习**：从简单到复杂的学习路径

### 关键要点

- **注释驱动开发**：清晰的注释是AI生成高质量代码的关键
- **结构化思维**：按照业务逻辑组织代码结构
- **渐进式实现**：从简单功能开始，逐步完善复杂逻辑
- **持续优化**：基于AI生成的代码进行性能和安全优化

### 下一步学习

1. 选择一个场景进行深入实践
2. 在实际项目中应用这些模式
3. 总结个人的使用经验和最佳实践
4. 扩展到其他编程语言和框架

通过掌握这四个核心场景，您将能够充分利用AI辅助编程工具，显著提升开发效率和代码质量。
