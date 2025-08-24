# 演练1-Java版：机场登机口管理系统实战演练

## 演练概述

**时长**: 30分钟（25分钟实战 + 5分钟成果展示）  
**目标**: 掌握GitHub Copilot在Java项目开发中的高效应用技巧  
**场景**: 民航凯亚机场登机口智能管理系统开发  
**技术栈**: Java 17+, Spring Boot 3.x, Spring Data JPA, JUnit 5, Maven

---

## 业务背景

民航凯亚机场需要优化登机口管理系统，提高航班调度效率和乘客体验。系统需要：

- **实时跟踪登机口状态**：可用、占用、维护中、清洁中
- **智能分配算法**：根据航班类型、飞机大小、乘客数量等因素自动分配最优登机口
- **冲突检测**：避免时间冲突和资源冲突
- **数据统计**：登机口使用率、平均周转时间等指标

---

## 演练任务清单

### 任务1: 创建登机口状态数据模型（6分钟）

#### 1.1 需求分析
使用Copilot辅助分析业务需求：

```java
// TODO: 请使用Copilot帮我分析机场登机口管理系统的核心数据模型
// 考虑因素：
// - 登机口基本信息（编号、位置、类型、容量）
// - 航班信息（航班号、起飞时间、目的地、飞机型号、乘客数量）
// - 状态跟踪（当前状态、预计可用时间、维护记录）
// - 历史记录（使用历史、统计数据）
```

#### 1.2 枚举类定义
**Copilot提示技巧**: 通过详细注释引导代码生成

```java
// GateStatus.java - 登机口状态枚举

// TODO: 使用Copilot生成登机口状态枚举
// 状态包括：AVAILABLE(可用), OCCUPIED(占用), MAINTENANCE(维护), CLEANING(清洁)
// 每个状态需要包含中文描述和状态码
public enum GateStatus {
    // 使用Copilot生成完整枚举定义，包含构造函数和getter方法
}

// FlightType.java - 航班类型枚举
// TODO: 使用Copilot生成航班类型枚举
// 类型包括：DOMESTIC(国内), INTERNATIONAL(国际), CARGO(货运)
public enum FlightType {
    // 使用Copilot生成完整枚举定义
}

// AircraftType.java - 飞机类型枚举
// TODO: 使用Copilot生成飞机类型枚举
// 类型包括：SMALL(小型), MEDIUM(中型), LARGE(大型), WIDE_BODY(宽体机)
// 每个类型包含典型乘客容量范围
public enum AircraftType {
    // 使用Copilot生成完整枚举定义，包含容量范围
}
```

#### 1.3 JPA实体类设计
```java
// Gate.java - 登机口实体类

package com.kya.airport.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;
import java.util.List;

// TODO: 使用Copilot生成登机口JPA实体类
// 字段包括：id, gateNumber, terminal, gateType, capacity, currentStatus, 
//          lastUpdated, isActive, maintenanceNotes, location
// 添加适当的JPA注解和Lombok注解
@Entity
@Table(name = "gates")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Gate {
    // 使用Copilot生成完整的实体类定义
}

// Flight.java - 航班实体类
package com.kya.airport.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;

// TODO: 使用Copilot生成航班JPA实体类
// 字段包括：id, flightNumber, airline, aircraftType, passengerCount,
//          scheduledDeparture, estimatedDeparture, destination, flightType,
//          gate(关联关系), createdAt, updatedAt
// 包含与Gate的多对一关联关系
@Entity
@Table(name = "flights")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Flight {
    // 使用Copilot生成完整的实体类定义，包含JPA关联关系
}

// GateAssignment.java - 登机口分配记录实体类
package com.kya.airport.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;

// TODO: 使用Copilot生成登机口分配记录实体类
// 字段包括：id, gate(关联), flight(关联), assignedAt, releasedAt, 
//          actualBoardingTime, delayMinutes, notes
// 包含与Gate和Flight的多对一关联关系
@Entity
@Table(name = "gate_assignments")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class GateAssignment {
    // 使用Copilot生成完整的实体类定义
}
```

#### 1.4 DTO响应模型
```java
// GateInfoDto.java - 登机口信息响应DTO

package com.kya.airport.dto;

import lombok.Data;
import lombok.Builder;
import java.time.LocalDateTime;

// TODO: 使用Copilot生成登机口信息响应DTO
// 包含所有基本字段和当前分配的航班信息
// 使用Builder模式便于构建
@Data
@Builder
public class GateInfoDto {
    // 使用Copilot生成完整的DTO定义
}

// FlightInfoDto.java - 航班信息响应DTO
package com.kya.airport.dto;

import lombok.Data;
import lombok.Builder;
import java.time.LocalDateTime;

// TODO: 使用Copilot生成航班信息响应DTO
// 包含航班详情和分配的登机口信息
@Data
@Builder
public class FlightInfoDto {
    // 使用Copilot生成完整的DTO定义
}

// GateAssignmentRequestDto.java - 分配请求DTO
package com.kya.airport.dto;

import lombok.Data;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.time.LocalDateTime;

// TODO: 使用Copilot生成分配请求DTO
// 用于接收登机口分配请求参数
// 添加适当的验证注解
@Data
public class GateAssignmentRequestDto {
    // 使用Copilot生成完整的DTO定义，包含验证注解
}
```

#### 演示要点：
- **注释驱动生成**：通过详细的TODO注释引导Copilot生成精确的代码
- **注解应用**：使用JPA、Lombok、Validation注解
- **关联关系**：正确建立实体间的JPA关联关系

---

### 任务2: 实现登机口分配算法（8分钟）

#### 2.1 Repository接口设计
```java
// GateRepository.java - 登机口数据访问接口

package com.kya.airport.repository;

import com.kya.airport.entity.Gate;
import com.kya.airport.entity.GateStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;

// TODO: 使用Copilot生成登机口Repository接口
// 包含以下查询方法：
// 1. 根据状态查询登机口
// 2. 根据航站楼和状态查询
// 3. 查询指定时间段内可用的登机口
// 4. 根据容量范围查询登机口
// 5. 查询登机口使用统计信息
@Repository
public interface GateRepository extends JpaRepository<Gate, Long> {
    // 使用Copilot生成查询方法定义，包含自定义JPQL查询
}

// FlightRepository.java - 航班数据访问接口
package com.kya.airport.repository;

import com.kya.airport.entity.Flight;
import com.kya.airport.entity.FlightType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;

// TODO: 使用Copilot生成航班Repository接口
// 包含按时间段、航班类型、状态等条件的查询方法
@Repository
public interface FlightRepository extends JpaRepository<Flight, Long> {
    // 使用Copilot生成查询方法定义
}
```

#### 2.2 核心算法服务实现
使用Copilot Chat进行算法讨论：

```
Copilot Chat对话示例：
开发者: "我需要在Spring Boot项目中设计一个机场登机口智能分配算法，考虑以下因素：
1. 航班类型匹配（国际航班需要特定登机口）
2. 飞机大小与登机口容量匹配
3. 时间冲突避免（包含清洁和维护时间）
4. 距离优化（减少乘客步行距离）
5. 登机口周转时间
请用Java和Spring Boot实现，包含服务层设计和算法实现"

Copilot: [算法设计建议]
```

#### 2.3 算法服务实现
```java
// GateAllocationService.java - 登机口分配服务

package com.kya.airport.service;

import com.kya.airport.entity.*;
import com.kya.airport.repository.*;
import com.kya.airport.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.extern.slf4j.Slf4j;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Transactional
@Slf4j
public class GateAllocationService {
    
    @Autowired
    private GateRepository gateRepository;
    
    @Autowired
    private FlightRepository flightRepository;
    
    @Autowired
    private GateAssignmentRepository assignmentRepository;
    
    // TODO: 使用Copilot实现智能分配算法
    // 算法要求：
    // 1. 检查时间冲突 - 确保登机口在需要时间段内可用
    // 2. 容量匹配 - 登机口容量需要满足乘客数量
    // 3. 类型匹配 - 国际航班需要国际登机口
    // 4. 优先级计算 - 根据距离、设施等因素计算最佳匹配
    // 5. 返回推荐的登机口列表，按优先级排序
    public List<GateRecommendationDto> findOptimalGates(Flight flight) {
        /**
         * 为指定航班找到最优登机口
         * 
         * @param flight 需要分配登机口的航班对象
         * @return 按优先级排序的登机口推荐列表
         */
        // 使用Copilot实现完整算法逻辑
    }
    
    // TODO: 使用Copilot实现时间冲突检测
    // 考虑登机时间、清洁时间、维护时间等因素
    public boolean checkTimeConflict(Long gateId, LocalDateTime startTime, LocalDateTime endTime) {
        /**
         * 检查指定时间段内登机口是否有冲突
         * 
         * @param gateId 登机口ID
         * @param startTime 开始时间
         * @param endTime 结束时间
         * @return 是否有冲突
         */
        // 使用Copilot实现时间冲突检测逻辑
    }
    
    // TODO: 使用Copilot实现容量匹配算法
    // 根据飞机型号和乘客数量判断登机口是否合适
    public boolean checkCapacityMatch(Gate gate, Flight flight) {
        /**
         * 检查登机口容量是否满足航班需求
         * 
         * @param gate 登机口对象
         * @param flight 航班对象
         * @return 是否匹配
         */
        // 使用Copilot实现容量匹配逻辑
    }
    
    // TODO: 使用Copilot实现优先级计算算法
    // 综合考虑距离、设施、历史使用情况等因素
    public double calculatePriorityScore(Gate gate, Flight flight) {
        /**
         * 计算登机口与航班的匹配优先级分数
         * 
         * @param gate 登机口对象
         * @param flight 航班对象
         * @return 优先级分数（0-100）
         */
        // 使用Copilot实现优先级计算算法
    }
    
    // TODO: 使用Copilot实现自动分配功能
    // 完成分配后更新数据库状态
    public GateAssignmentResult assignGate(Long flightId, Long gateId) {
        /**
         * 执行登机口分配并更新状态
         * 
         * @param flightId 航班ID
         * @param gateId 登机口ID
         * @return 分配结果
         */
        // 使用Copilot实现分配逻辑，包含事务处理
    }
    
    // TODO: 使用Copilot实现批量分配优化
    // 对多个航班进行全局优化分配
    public Map<Long, Long> batchOptimizeAssignment(List<Long> flightIds) {
        /**
         * 批量优化多个航班的登机口分配
         * 
         * @param flightIds 航班ID列表
         * @return 航班ID到登机口ID的映射
         */
        // 使用Copilot实现批量优化逻辑
    }
}
```

#### 2.4 业务规则配置
```java
// GateAllocationConfig.java - 业务规则配置

package com.kya.airport.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import lombok.Data;

// TODO: 使用Copilot生成业务规则配置类
// 包括：清洁时间、周转时间、容量系数、距离权重等
// 使用@ConfigurationProperties从application.yml读取配置
@Configuration
@ConfigurationProperties(prefix = "airport.gate.allocation")
@Data
public class GateAllocationConfig {
    /**
     * 登机口分配算法配置参数
     */
    // 使用Copilot生成配置属性定义
}
```

#### 演示要点：
- **Spring Boot集成**：使用Spring的依赖注入和事务管理
- **算法讨论**：使用Copilot Chat进行算法设计讨论
- **分步实现**：将复杂算法拆分为多个可测试的方法

---

### 任务3: 编写单元测试用例（6分钟）

#### 3.1 测试配置和基础设施
```java
// GateAllocationServiceTest.java - 登机口服务测试类

package com.kya.airport.service;

import com.kya.airport.entity.*;
import com.kya.airport.repository.*;
import com.kya.airport.dto.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Arrays;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

// TODO: 使用Copilot生成测试类基础配置
// 配置Mockito、SpringBoot测试环境
@ExtendWith(MockitoExtension.class)
@SpringBootTest
@TestPropertySource(properties = {
    "spring.datasource.url=jdbc:h2:mem:testdb",
    "spring.jpa.hibernate.ddl-auto=create-drop"
})
class GateAllocationServiceTest {
    
    @Mock
    private GateRepository gateRepository;
    
    @Mock
    private FlightRepository flightRepository;
    
    @Mock
    private GateAssignmentRepository assignmentRepository;
    
    @InjectMocks
    private GateAllocationService gateAllocationService;
    
    // TODO: 使用Copilot生成测试数据工厂方法
    // 创建各种测试场景的示例数据
    private Gate createTestGate(String gateNumber, GateStatus status, int capacity) {
        // 使用Copilot生成测试数据创建方法
    }
    
    private Flight createTestFlight(String flightNumber, FlightType type, int passengerCount) {
        // 使用Copilot生成航班测试数据
    }
    
    private List<Gate> createTestGateList() {
        // 使用Copilot生成测试登机口列表
    }
    
    // TODO: 使用Copilot生成基础功能测试
    // 测试正常情况下的登机口分配
    @Test
    @DisplayName("正常情况下查找最优登机口")
    void testFindOptimalGatesNormalCase() {
        // Given
        Flight testFlight = createTestFlight("CA1234", FlightType.DOMESTIC, 180);
        List<Gate> availableGates = createTestGateList();
        
        when(gateRepository.findAvailableGatesForTimeRange(any(), any()))
            .thenReturn(availableGates);
        
        // When & Then - 使用Copilot生成测试逻辑
    }
    
    // TODO: 使用Copilot生成边界条件测试  
    // 测试没有可用登机口的情况
    @Test
    @DisplayName("无可用登机口情况测试")
    void testFindOptimalGatesNoAvailable() {
        // 使用Copilot生成测试逻辑
    }
    
    // TODO: 使用Copilot生成时间冲突测试
    // 测试时间冲突检测功能
    @Test
    @DisplayName("时间冲突检测算法测试")
    void testTimeConflictDetection() {
        // 使用Copilot生成时间冲突测试逻辑
    }
    
    // TODO: 使用Copilot生成容量匹配测试
    // 测试各种容量匹配场景
    @ParameterizedTest
    @ValueSource(ints = {50, 150, 250, 400})
    @DisplayName("容量匹配算法测试")
    void testCapacityMatching(int passengerCount) {
        // 使用Copilot生成参数化测试逻辑
    }
    
    // TODO: 使用Copilot生成优先级计算测试
    // 测试优先级评分算法的准确性
    @Test
    @DisplayName("优先级计算算法测试")
    void testPriorityScoreCalculation() {
        // 使用Copilot生成优先级测试逻辑
    }
    
    // TODO: 使用Copilot生成异常处理测试
    // 测试各种异常情况的处理
    @Test
    @DisplayName("异常情况处理测试")
    void testExceptionHandling() {
        // 使用Copilot生成异常处理测试
    }
    
    // TODO: 使用Copilot生成事务测试
    // 测试分配操作的事务一致性
    @Test
    @Transactional
    @DisplayName("事务一致性测试")
    void testTransactionConsistency() {
        // 使用Copilot生成事务测试逻辑
    }
}
```

#### 3.2 集成测试
```java
// GateAllocationIntegrationTest.java - 集成测试类

package com.kya.airport.integration;

import com.kya.airport.entity.*;
import com.kya.airport.repository.*;
import com.kya.airport.service.GateAllocationService;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

// TODO: 使用Copilot生成集成测试
// 测试完整的业务流程，包含数据库操作
@SpringBootTest
@TestPropertySource(properties = {
    "spring.datasource.url=jdbc:h2:mem:integrationtest",
    "spring.jpa.hibernate.ddl-auto=create-drop"
})
@Transactional
class GateAllocationIntegrationTest {
    
    @Autowired
    private GateAllocationService gateAllocationService;
    
    @Autowired
    private GateRepository gateRepository;
    
    @Autowired
    private FlightRepository flightRepository;
    
    @BeforeEach
    void setUp() {
        // TODO: 使用Copilot生成测试数据初始化
        // 创建测试用的登机口和航班数据
    }
    
    @Test
    @DisplayName("完整分配工作流程测试")
    void testCompleteAllocationWorkflow() {
        // TODO: 使用Copilot生成完整流程测试
        // 包含：查询可用登机口 -> 分配 -> 验证状态更新 -> 释放
    }
    
    @Test
    @DisplayName("批量优化功能测试")
    void testBatchOptimization() {
        // TODO: 使用Copilot生成批量优化测试
    }
    
    @Test
    @DisplayName("并发分配测试")
    void testConcurrentAllocation() {
        // TODO: 使用Copilot生成并发测试
    }
}
```

#### 3.3 性能测试
```java
// GateAllocationPerformanceTest.java - 性能测试

package com.kya.airport.performance;

import com.kya.airport.service.GateAllocationService;
import org.junit.jupiter.api.*;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import java.time.Duration;
import java.util.concurrent.TimeUnit;

// TODO: 使用Copilot生成性能测试类
// 测试不同数据规模下的算法性能
@SpringBootTest
@TestPropertySource(properties = {"spring.profiles.active=test"})
class GateAllocationPerformanceTest {
    
    @Test
    @Timeout(value = 5, unit = TimeUnit.SECONDS)
    @DisplayName("100个登机口分配性能测试")
    void testAllocationSpeed100Gates() {
        // TODO: 使用Copilot生成性能测试逻辑
    }
    
    @Test
    @Timeout(value = 10, unit = TimeUnit.SECONDS)
    @DisplayName("1000个航班分配性能测试") 
    void testAllocationSpeed1000Flights() {
        // TODO: 使用Copilot生成大数据量性能测试
    }
}
```

#### 演示要点：
- **JUnit 5应用**：使用现代测试框架和注解
- **Mockito集成**：模拟依赖对象进行单元测试
- **参数化测试**：使用@ParameterizedTest进行多场景测试
- **集成测试**：使用内存数据库进行完整流程测试

---

### 任务4: 生成REST API接口（5分钟）

#### 4.1 REST Controller实现
```java
// GateController.java - 登机口管理控制器

package com.kya.airport.controller;

import com.kya.airport.dto.*;
import com.kya.airport.entity.GateStatus;
import com.kya.airport.service.GateAllocationService;
import io.swagger.v3.oas.annotations.*;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/v1/gates")
@Slf4j
@Tag(name = "登机口管理", description = "机场登机口智能管理API")
public class GateController {
    
    @Autowired
    private GateAllocationService gateAllocationService;
    
    // TODO: 使用Copilot生成登机口查询API
    // 包含详细的参数说明和响应示例，支持分页和条件筛选
    @GetMapping
    @Operation(summary = "获取登机口列表", description = "根据条件查询登机口信息，支持分页")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "查询成功"),
        @ApiResponse(responseCode = "400", description = "参数错误")
    })
    public ResponseEntity<ApiResponse<Page<GateInfoDto>>> getGates(
            @Parameter(description = "登机口状态筛选") @RequestParam(required = false) GateStatus status,
            @Parameter(description = "航站楼筛选") @RequestParam(required = false) String terminal,
            @Parameter(description = "最小容量") @RequestParam(required = false) Integer minCapacity,
            Pageable pageable) {
        // TODO: 使用Copilot实现查询逻辑
        /**
         * 根据条件查询登机口列表
         * 支持按状态、航站楼、容量筛选，并支持分页
         */
    }
    
    // TODO: 使用Copilot生成智能分配API
    // 包含算法参数和分配结果说明
    @PostMapping("/allocate")
    @Operation(summary = "智能分配登机口", description = "根据航班信息和业务规则，自动推荐最优登机口")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "分配成功"),
        @ApiResponse(responseCode = "400", description = "参数验证失败"),
        @ApiResponse(responseCode = "409", description = "分配冲突")
    })
    public ResponseEntity<ApiResponse<GateAllocationResult>> allocateGate(
            @Valid @RequestBody GateAssignmentRequestDto request) {
        // TODO: 使用Copilot实现智能分配逻辑
        /**
         * 执行智能登机口分配
         * 返回推荐的登机口列表和分配结果
         */
    }
    
    // TODO: 使用Copilot生成状态更新API
    @PatchMapping("/{gateId}/status")
    @Operation(summary = "更新登机口状态", description = "更新指定登机口的状态")
    public ResponseEntity<ApiResponse<Void>> updateGateStatus(
            @PathVariable Long gateId,
            @RequestBody GateStatusUpdateDto statusUpdate) {
        // TODO: 使用Copilot实现状态更新逻辑
    }
    
    // TODO: 使用Copilot生成分配历史查询API
    @GetMapping("/assignments")
    @Operation(summary = "查询分配历史", description = "查询登机口分配历史记录")
    public ResponseEntity<ApiResponse<List<GateAssignmentDto>>> getAssignments(
            @RequestParam LocalDateTime startDate,
            @RequestParam LocalDateTime endDate,
            @RequestParam(required = false) Long gateId) {
        // TODO: 使用Copilot实现历史查询逻辑
    }
    
    // TODO: 使用Copilot生成统计分析API
    @GetMapping("/statistics")
    @Operation(summary = "登机口使用统计", description = "获取登机口使用率和效率统计")
    public ResponseEntity<ApiResponse<GateStatisticsDto>> getGateStatistics(
            @RequestParam LocalDateTime startDate,
            @RequestParam LocalDateTime endDate) {
        // TODO: 使用Copilot实现统计分析逻辑
    }
}

// FlightController.java - 航班管理控制器
package com.kya.airport.controller;

import com.kya.airport.dto.*;
import com.kya.airport.service.FlightService;
import io.swagger.v3.oas.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/v1/flights")
@Tag(name = "航班管理", description = "航班信息管理API")
public class FlightController {
    
    @Autowired
    private FlightService flightService;
    
    // TODO: 使用Copilot生成航班管理相关API
    // 包含航班CRUD操作和状态管理
}
```

#### 4.2 统一响应格式
```java
// ApiResponse.java - 统一API响应格式

package com.kya.airport.dto;

import lombok.Data;
import lombok.Builder;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

// TODO: 使用Copilot生成统一API响应格式
// 包含成功/失败状态、消息、数据、时间戳等字段
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ApiResponse<T> {
    // 使用Copilot生成完整的响应格式定义
}

// ApiResponseUtil.java - 响应工具类
package com.kya.airport.util;

import com.kya.airport.dto.ApiResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

// TODO: 使用Copilot生成响应工具类
// 包含success、error等静态方法，简化响应构建
public class ApiResponseUtil {
    // 使用Copilot生成工具方法
}
```

#### 4.3 异常处理和验证
```java
// GlobalExceptionHandler.java - 全局异常处理器

package com.kya.airport.exception;

import com.kya.airport.dto.ApiResponse;
import com.kya.airport.util.ApiResponseUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import java.util.HashMap;
import java.util.Map;

// TODO: 使用Copilot生成全局异常处理器
// 处理参数验证、业务异常、系统异常等各类异常
@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {
    
    // TODO: 使用Copilot生成参数验证异常处理
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiResponse<Map<String, String>>> handleValidationExceptions(
            MethodArgumentNotValidException ex) {
        // 使用Copilot生成验证异常处理逻辑
    }
    
    // TODO: 使用Copilot生成业务异常处理
    @ExceptionHandler(BusinessException.class) 
    public ResponseEntity<ApiResponse<String>> handleBusinessException(BusinessException ex) {
        // 使用Copilot生成业务异常处理逻辑
    }
    
    // TODO: 使用Copilot生成通用异常处理
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiResponse<String>> handleGenericException(Exception ex) {
        // 使用Copilot生成通用异常处理逻辑
    }
}
```

#### 4.4 API文档配置
```java
// OpenApiConfig.java - Swagger文档配置

package com.kya.airport.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.Contact;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

// TODO: 使用Copilot生成OpenAPI配置
// 配置API文档信息、安全认证、服务器信息等
@Configuration
public class OpenApiConfig {
    
    @Bean
    public OpenAPI customOpenAPI() {
        // TODO: 使用Copilot生成OpenAPI配置
        // 包含项目信息、联系方式、版本号等
    }
}
```

#### 演示要点：
- **Swagger集成**：使用OpenAPI 3.0生成交互式API文档
- **参数验证**：使用Bean Validation进行请求参数验证
- **统一响应**：设计一致的API响应格式
- **异常处理**：全局异常处理器处理各类异常情况

---

## Copilot使用技巧总结

### 1. Java特定的注释驱动技巧
**最佳实践**：
```java
// ✅ 好的注释（包含Java特性）
// TODO: 使用Copilot实现登机口智能分配算法  
// 输入：Flight对象(flightNumber, passengerCount, flightType, departureTime)
// 输出：List<GateRecommendationDto>，按优先级排序
// 技术要求：使用Stream API进行数据处理，考虑并发安全
// 算法：时间冲突检测 + 容量匹配 + 类型匹配 + 距离优化
// 异常处理：处理数据不一致和并发冲突情况

// ❌ 不好的注释（过于简单）
// TODO: 分配登机口
```

### 2. Spring Boot特定的Copilot应用
**框架集成提示**：
```java
// 在需要Spring特性时明确指出
// TODO: 使用Copilot创建Spring Boot服务类
// 要求：使用@Service注解，注入Repository依赖，添加@Transactional事务支持
// 异常：抛出自定义业务异常，由GlobalExceptionHandler处理

// 数据库操作提示
// TODO: 使用Copilot创建JPA Repository方法
// 要求：使用方法命名约定自动生成查询，复杂查询使用@Query注解
// 返回：支持分页和排序，使用Optional处理可能为空的结果
```

### 3. 测试驱动的Copilot应用
**测试生成策略**：
```java
// 明确测试框架和工具
// TODO: 使用Copilot创建JUnit 5单元测试
// 框架：JUnit 5 + Mockito + AssertJ
// 覆盖：正常流程、边界条件、异常情况
// 模拟：使用@Mock注解模拟依赖，when().thenReturn()设置行为
// 断言：使用AssertJ的流式断言，提高可读性
```

### 4. API设计的Copilot应用
**RESTful API生成**：
```java
// TODO: 使用Copilot创建RESTful控制器
// 要求：遵循REST规范，使用适当的HTTP方法和状态码
// 文档：使用OpenAPI注解生成详细文档
// 验证：使用Bean Validation验证请求参数
// 响应：统一响应格式，包含成功/失败状态和详细消息
```

---

## 成果展示环节（5分钟）

### 展示内容
每组选派代表演示以下内容：

1. **代码架构评估**（2分钟）
   - Spring Boot项目结构的合理性
   - 层次划分和依赖关系
   - JPA实体设计和关联关系
   - 服务层业务逻辑的清晰度

2. **Copilot应用技巧**（2分钟）
   - Java/Spring特定的提示技巧
   - 最有效的代码生成场景
   - 测试用例生成的效果
   - API文档生成的完整性

3. **项目亮点展示**（1分钟）
   - 最满意的算法实现
   - 创新的业务逻辑设计
   - 完整的异常处理机制
   - API的易用性和文档质量

### 评估标准
- **架构设计**：Spring Boot最佳实践应用，层次清晰
- **代码质量**：Java编码规范，注解使用得当，异常处理完善
- **测试覆盖**：单元测试、集成测试、性能测试的完整性
- **API设计**：RESTful规范遵循，文档完整，响应格式统一

### 讲师点评要点
- 突出Java生态系统中Copilot的优势
- 指出Spring Boot项目中的常见陷阱
- 分享企业级开发的最佳实践
- 预告微服务架构中的AI应用

---

## 课后作业

### 基础任务
1. **完善业务逻辑**：添加登机口维护计划管理功能
2. **增强测试覆盖**：添加更多集成测试和性能测试用例
3. **优化算法实现**：使用并行流优化大数据量处理性能

### 进阶任务
1. **Redis集成**：添加缓存层提升查询性能
2. **消息队列**：使用RabbitMQ实现异步处理
3. **监控集成**：集成Micrometer和Prometheus监控
4. **安全认证**：添加Spring Security JWT认证

### 专家任务
1. **微服务拆分**：将单体应用拆分为微服务架构
2. **容器化部署**：创建Docker镜像和Kubernetes部署配置
3. **CI/CD流水线**：设计GitHub Actions自动化部署流程

### 提交要求
- 代码提交到个人GitHub仓库
- 包含完整的README文档和API文档
- 记录Copilot在Java项目中的使用心得
- 提供性能测试报告和优化建议

---

## 资源链接

### 官方文档
- [GitHub Copilot官方文档](https://docs.github.com/copilot)
- [Spring Boot官方文档](https://spring.io/projects/spring-boot)
- [Spring Data JPA参考指南](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/)
- [JUnit 5用户指南](https://junit.org/junit5/docs/current/user-guide/)

### 最佳实践参考
- [Java代码规范 Google Style](https://google.github.io/styleguide/javaguide.html)
- [Spring Boot最佳实践](https://spring.io/guides)
- [RESTful API设计规范](https://restfulapi.net/)
- [微服务设计模式](https://microservices.io/patterns/)

### 工具和框架
- [Maven中央仓库](https://mvnrepository.com/)
- [Spring Initializr](https://start.spring.io/)
- [H2数据库文档](https://h2database.com/html/main.html)
- [Swagger编辑器](https://editor.swagger.io/)

---

**实战演练完成！** 

通过这个Java版本的演练，学员将掌握：
- ✅ GitHub Copilot在Java/Spring Boot项目中的高效应用
- ✅ 企业级Java应用的架构设计和实现
- ✅ Spring生态系统的深度集成技巧
- ✅ JPA/Hibernate的实体设计和查询优化
- ✅ JUnit 5和Mockito的现代测试实践
- ✅ RESTful API的标准设计和文档生成
- ✅ Java项目的异常处理和参数验证

相比Python版本，Java版本更加注重：
- 类型安全和编译时检查
- 企业级框架集成
- 面向对象设计模式
- 工业级代码规范
- 完整的测试金字塔
- 生产环境部署考虑

这为学员在企业级Java开发中应用AI工具提供了完整的实践基础！
