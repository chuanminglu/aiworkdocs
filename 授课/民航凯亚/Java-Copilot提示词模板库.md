# GitHub Copilot Java 提示词模板库

## 📚 文档说明

本文档提供了基于Java语言的GitHub Copilot提示词模板，帮助团队成员快速生成一致、高质量的代码。每个模板都包含详细的注释说明和最佳实践。

---

## 🗄️ 模板1：数据库CRUD操作模板

### 基础CRUD服务类模板

```java
/**
 * {实体名称}数据访问服务类
 * 
 * 功能包括：
 * 1. 基础CRUD操作 - 增删改查
 * 2. 分页查询 - 支持排序和过滤
 * 3. 批量操作 - 批量插入、更新、删除
 * 4. 条件查询 - 复杂查询条件支持
 * 5. 事务管理 - 确保数据一致性
 * 
 * 技术栈：Spring Data JPA + MySQL
 * 异常处理：统一异常处理和日志记录
 */
@Service
@Transactional
@Slf4j
public class {EntityName}Service {
    
    private final {EntityName}Repository repository;
    
    public {EntityName}Service({EntityName}Repository repository) {
        this.repository = repository;
    }
    
    /**
     * 创建新记录
     * 
     * 业务规则：
     * - 验证必填字段
     * - 检查重复约束
     * - 设置默认值
     * - 记录操作日志
     * 
     * @param entity 待创建的实体对象
     * @return 创建成功的实体（包含生成的ID）
     * @throws ValidationException 数据验证失败
     * @throws DuplicateException 重复数据冲突
     */
    public {EntityName} create({EntityName} entity) {
        // TODO: 使用Copilot实现创建逻辑
        // 1. 数据验证
        // 2. 重复检查
        // 3. 保存实体
        // 4. 记录日志
        // 5. 返回结果
    }
    
    /**
     * 根据ID查询记录
     * 
     * @param id 实体ID
     * @return 查询结果，不存在时返回Optional.empty()
     */
    public Optional<{EntityName}> findById(Long id) {
        // TODO: 实现按ID查询，包含异常处理和日志记录
    }
    
    /**
     * 分页查询记录
     * 
     * 查询特性：
     * - 支持多字段排序
     * - 支持动态过滤条件
     * - 支持关联查询
     * - 性能优化（避免N+1问题）
     * 
     * @param pageable 分页参数（页码、大小、排序）
     * @param criteria 查询条件
     * @return 分页结果
     */
    public Page<{EntityName}> findByPage(Pageable pageable, {EntityName}SearchCriteria criteria) {
        // TODO: 实现分页查询，使用Specification进行动态条件构建
    }
    
    /**
     * 更新记录
     * 
     * 更新策略：
     * - 乐观锁控制并发
     * - 部分字段更新
     * - 审计字段自动更新
     * - 业务规则验证
     * 
     * @param id 待更新记录ID
     * @param updateRequest 更新请求对象
     * @return 更新后的实体
     * @throws OptimisticLockException 并发更新冲突
     * @throws EntityNotFoundException 记录不存在
     */
    public {EntityName} update(Long id, {EntityName}UpdateRequest updateRequest) {
        // TODO: 实现更新逻辑，包含版本控制和字段验证
    }
    
    /**
     * 批量操作模板
     * 
     * 性能优化：
     * - 使用批量SQL减少数据库交互
     * - 分批处理避免内存溢出
     * - 事务控制确保一致性
     * - 进度回调支持
     * 
     * @param entities 待操作的实体列表
     * @param batchSize 批量大小（默认1000）
     * @return 操作结果统计
     */
    public BatchOperationResult batchInsert(List<{EntityName}> entities, int batchSize) {
        // TODO: 实现批量插入，包含分批处理和进度跟踪
    }
    
    /**
     * 软删除记录
     * 
     * 删除策略：
     * - 软删除标记（deleted_at字段）
     * - 关联数据处理
     * - 删除权限验证
     * - 删除审计日志
     * 
     * @param id 待删除记录ID
     * @throws EntityNotFoundException 记录不存在
     * @throws BusinessException 业务规则阻止删除
     */
    public void softDelete(Long id) {
        // TODO: 实现软删除逻辑，更新deleted_at字段而非物理删除
    }
}
```

### Repository接口模板

```java
/**
 * {实体名称}数据访问接口
 * 
 * 继承JpaRepository获得基础CRUD功能
 * 继承JpaSpecificationExecutor支持动态查询
 * 自定义查询方法遵循Spring Data命名规范
 */
@Repository
public interface {EntityName}Repository extends JpaRepository<{EntityName}, Long>, JpaSpecificationExecutor<{EntityName}> {
    
    /**
     * 按状态查询活跃记录
     * TODO: 根据status字段查询，排除软删除记录
     */
    List<{EntityName}> findByStatusAndDeletedAtIsNull(String status);
    
    /**
     * 按创建时间范围查询
     * TODO: 时间范围查询，支持分页
     */
    Page<{EntityName}> findByCreatedAtBetween(LocalDateTime startTime, LocalDateTime endTime, Pageable pageable);
    
    /**
     * 复杂统计查询
     * TODO: 使用@Query注解编写复杂SQL，返回统计结果
     */
    @Query("SELECT new com.example.dto.{EntityName}Statistics(e.status, COUNT(e)) FROM {EntityName} e GROUP BY e.status")
    List<{EntityName}Statistics> getStatisticsByStatus();
    
    /**
     * 自定义更新操作
     * TODO: 使用@Modifying注解进行批量更新
     */
    @Modifying
    @Query("UPDATE {EntityName} e SET e.status = :newStatus WHERE e.id IN :ids")
    int batchUpdateStatus(@Param("ids") List<Long> ids, @Param("newStatus") String newStatus);
}
```

---

## 🔌 模板2：API接口设计模板

### RESTful Controller模板

```java
/**
 * {实体名称}REST API控制器
 * 
 * API设计规范：
 * - RESTful风格URL设计
 * - 统一响应格式
 * - 完整的HTTP状态码
 * - 请求参数验证
 * - API版本控制
 * - 接口文档自动生成
 * 
 * 安全控制：
 * - JWT认证
 * - 权限验证
 * - 请求限流
 * - 输入sanitization
 */
@RestController
@RequestMapping("/api/v1/{entityPath}")
@Validated
@Slf4j
@Tag(name = "{EntityName} Management", description = "{实体名称}管理相关API")
public class {EntityName}Controller {
    
    private final {EntityName}Service service;
    private final {EntityName}Mapper mapper;
    
    public {EntityName}Controller({EntityName}Service service, {EntityName}Mapper mapper) {
        this.service = service;
        this.mapper = mapper;
    }
    
    /**
     * 创建{实体名称}
     * 
     * API规范：
     * - POST方法
     * - 请求体JSON格式
     * - 返回201状态码和创建的资源
     * - Location头部包含新资源URI
     * 
     * 验证规则：
     * - @Valid注解验证请求体
     * - 自定义业务规则验证
     * - 重复性检查
     * 
     * @param createRequest 创建请求DTO
     * @return 创建成功的资源信息
     */
    @PostMapping
    @Operation(summary = "创建{实体名称}", description = "创建新的{实体名称}记录")
    @ApiResponses({
        @ApiResponse(responseCode = "201", description = "创建成功"),
        @ApiResponse(responseCode = "400", description = "请求参数错误"),
        @ApiResponse(responseCode = "409", description = "资源冲突")
    })
    public ResponseEntity<ApiResponse<{EntityName}Response>> create(
            @Valid @RequestBody {EntityName}CreateRequest createRequest) {
        
        // TODO: 使用Copilot实现创建API逻辑
        // 1. 请求参数验证
        // 2. DTO转换为实体
        // 3. 调用service创建
        // 4. 实体转换为响应DTO
        // 5. 构建响应（包含Location头）
        // 6. 记录API调用日志
    }
    
    /**
     * 查询{实体名称}详情
     * 
     * @param id {实体名称}ID
     * @return {实体名称}详细信息
     */
    @GetMapping("/{id}")
    @Operation(summary = "获取{实体名称}详情")
    public ResponseEntity<ApiResponse<{EntityName}Response>> getById(
            @PathVariable @Min(1) Long id) {
        
        // TODO: 实现查询详情API
        // 1. 参数验证
        // 2. 调用service查询
        // 3. 处理未找到情况（404）
        // 4. 实体转DTO
        // 5. 构建成功响应
    }
    
    /**
     * 分页查询{实体名称}列表
     * 
     * 查询参数：
     * - page: 页码（从0开始）
     * - size: 每页大小（默认20，最大100）
     * - sort: 排序字段和方向
     * - 其他过滤条件
     * 
     * @param pageable 分页参数
     * @param searchParams 查询条件
     * @return 分页查询结果
     */
    @GetMapping
    @Operation(summary = "分页查询{实体名称}列表")
    public ResponseEntity<ApiResponse<PageResponse<{EntityName}Response>>> getByPage(
            @PageableDefault(size = 20, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable,
            @Valid {EntityName}SearchParams searchParams) {
        
        // TODO: 实现分页查询API
        // 1. 分页参数验证（大小限制）
        // 2. 搜索条件构建
        // 3. 调用service分页查询
        // 4. Page转换为PageResponse
        // 5. 添加分页元数据
    }
    
    /**
     * 更新{实体名称}
     * 
     * 更新策略：
     * - PUT方法（完整更新）
     * - PATCH方法（部分更新）
     * - 乐观锁版本控制
     * - 更新权限验证
     * 
     * @param id 待更新{实体名称}ID
     * @param updateRequest 更新请求
     * @return 更新后的{实体名称}信息
     */
    @PutMapping("/{id}")
    @Operation(summary = "更新{实体名称}")
    public ResponseEntity<ApiResponse<{EntityName}Response>> update(
            @PathVariable Long id,
            @Valid @RequestBody {EntityName}UpdateRequest updateRequest) {
        
        // TODO: 实现更新API
        // 1. ID和版本号验证
        // 2. 更新权限检查
        // 3. 调用service更新
        // 4. 处理并发冲突
        // 5. 返回更新结果
    }
    
    /**
     * 删除{实体名称}
     * 
     * 删除策略：
     * - 软删除优先
     * - 删除权限验证
     * - 关联数据检查
     * - 删除操作审计
     * 
     * @param id 待删除{实体名称}ID
     */
    @DeleteMapping("/{id}")
    @Operation(summary = "删除{实体名称}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable Long id) {
        
        // TODO: 实现删除API
        // 1. 删除权限验证
        // 2. 关联数据检查
        // 3. 执行软删除
        // 4. 记录删除日志
        // 5. 返回204状态码
    }
    
    /**
     * 批量操作API
     * 
     * 支持的批量操作：
     * - 批量创建
     * - 批量更新状态
     * - 批量删除
     * - 批量导入
     * 
     * @param batchRequest 批量操作请求
     * @return 批量操作结果
     */
    @PostMapping("/batch")
    @Operation(summary = "批量操作{实体名称}")
    public ResponseEntity<ApiResponse<BatchOperationResult>> batchOperation(
            @Valid @RequestBody {EntityName}BatchRequest batchRequest) {
        
        // TODO: 实现批量操作API
        // 1. 操作类型验证
        // 2. 批量大小限制
        // 3. 异步处理支持
        // 4. 进度跟踪
        // 5. 结果统计返回
    }
}
```

### 统一响应格式模板

```java
/**
 * 统一API响应格式
 * 
 * 响应结构：
 * - success: 操作是否成功
 * - code: 业务状态码
 * - message: 响应消息
 * - data: 业务数据
 * - timestamp: 响应时间戳
 * - traceId: 请求追踪ID
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ApiResponse<T> {
    
    private boolean success;
    private String code;
    private String message;
    private T data;
    private Long timestamp;
    private String traceId;
    
    /**
     * 成功响应构建器
     * TODO: 使用Copilot生成各种成功响应的静态工厂方法
     * 包括：成功无数据、成功有数据、创建成功等场景
     */
    public static <T> ApiResponse<T> success(T data) {
        // TODO: 实现成功响应构建逻辑
    }
    
    /**
     * 失败响应构建器
     * TODO: 使用Copilot生成各种失败响应的静态工厂方法
     * 包括：参数错误、业务异常、系统错误等场景
     */
    public static <T> ApiResponse<T> failure(String code, String message) {
        // TODO: 实现失败响应构建逻辑
    }
    
    /**
     * 分页响应构建器
     * TODO: 专门处理分页数据的响应格式
     */
    public static <T> ApiResponse<PageResponse<T>> page(Page<T> page) {
        // TODO: 实现分页响应构建逻辑
    }
}
```

---

## ⚠️ 模板3：异常处理模板

### 全局异常处理器模板

```java
/**
 * 全局异常处理器
 * 
 * 处理的异常类型：
 * 1. 参数验证异常 - @Valid验证失败
 * 2. 业务逻辑异常 - 自定义业务异常
 * 3. 数据访问异常 - JPA/数据库异常
 * 4. 系统异常 - 未预期的系统错误
 * 5. 安全异常 - 认证授权异常
 * 
 * 异常处理原则：
 * - 统一异常响应格式
 * - 敏感信息脱敏
 * - 详细错误日志记录
 * - 国际化错误消息
 */
@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {
    
    private final MessageSource messageSource;
    
    public GlobalExceptionHandler(MessageSource messageSource) {
        this.messageSource = messageSource;
    }
    
    /**
     * 参数验证异常处理
     * 
     * 处理场景：
     * - @Valid注解验证失败
     * - @RequestParam参数格式错误
     * - @PathVariable参数类型错误
     * - JSON反序列化异常
     * 
     * @param ex 验证异常
     * @return 统一的错误响应
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiResponse<Map<String, String>> handleValidationException(MethodArgumentNotValidException ex) {
        
        // TODO: 使用Copilot实现参数验证异常处理
        // 1. 提取所有验证错误
        // 2. 构建字段-错误消息映射
        // 3. 记录详细错误日志
        // 4. 返回400状态码和错误详情
        // 5. 支持国际化错误消息
    }
    
    /**
     * 业务逻辑异常处理
     * 
     * 自定义业务异常层次结构：
     * - BusinessException (基础业务异常)
     *   - EntityNotFoundException (资源未找到)
     *   - DuplicateException (重复资源)
     *   - InsufficientPermissionException (权限不足)
     *   - BusinessRuleViolationException (业务规则违反)
     * 
     * @param ex 业务异常
     * @return 业务错误响应
     */
    @ExceptionHandler(BusinessException.class)
    public ResponseEntity<ApiResponse<String>> handleBusinessException(BusinessException ex) {
        
        // TODO: 实现业务异常处理逻辑
        // 1. 根据异常类型确定HTTP状态码
        // 2. 提取业务错误码和消息
        // 3. 记录业务异常日志（区分错误级别）
        // 4. 构建标准化错误响应
        // 5. 支持错误码到HTTP状态码的映射
    }
    
    /**
     * 数据访问异常处理
     * 
     * 数据库异常分类：
     * - 数据完整性约束异常
     * - 乐观锁冲突异常
     * - 数据库连接异常
     * - SQL语法异常
     * - 事务回滚异常
     * 
     * @param ex 数据访问异常
     * @return 数据库错误响应
     */
    @ExceptionHandler({DataAccessException.class, JpaSystemException.class})
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ApiResponse<String> handleDataAccessException(Exception ex) {
        
        // TODO: 实现数据访问异常处理
        // 1. 异常类型识别和分类
        // 2. 敏感信息过滤（不暴露SQL细节）
        // 3. 用户友好的错误消息转换
        // 4. 详细的系统日志记录
        // 5. 根据环境决定错误详情暴露程度
    }
    
    /**
     * 系统异常处理
     * 
     * 未预期异常包括：
     * - NullPointerException
     * - IllegalArgumentException  
     * - ClassCastException
     * - 其他RuntimeException
     * 
     * @param ex 系统异常
     * @return 系统错误响应
     */
    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ApiResponse<String> handleGenericException(Exception ex) {
        
        // TODO: 实现系统异常处理
        // 1. 生成唯一错误ID便于追踪
        // 2. 记录完整的异常栈跟踪
        // 3. 发送告警通知（邮件/钉钉）
        // 4. 返回通用错误消息（不暴露系统细节）
        // 5. 集成APM工具进行异常监控
    }
    
    /**
     * 安全相关异常处理
     * 
     * 安全异常类型：
     * - 认证失败 (AuthenticationException)
     * - 权限不足 (AccessDeniedException)
     * - Token过期 (TokenExpiredException)
     * - 账户锁定 (AccountLockedException)
     * 
     * @param ex 安全异常
     * @return 安全错误响应
     */
    @ExceptionHandler({AuthenticationException.class, AccessDeniedException.class})
    public ResponseEntity<ApiResponse<String>> handleSecurityException(Exception ex) {
        
        // TODO: 实现安全异常处理
        // 1. 安全异常类型识别
        // 2. 记录安全日志（包含IP、用户等）
        // 3. 返回适当的HTTP状态码（401/403）
        // 4. 触发安全告警机制
        // 5. 避免信息泄露的错误消息
    }
}
```

### 自定义业务异常模板

```java
/**
 * 自定义业务异常基类
 * 
 * 异常设计原则：
 * - 继承RuntimeException，避免强制处理
 * - 包含错误码，便于前端处理
 * - 支持国际化消息
 * - 包含上下文信息
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class BusinessException extends RuntimeException {
    
    private final String errorCode;
    private final Object[] messageArgs;
    private final Map<String, Object> context;
    
    public BusinessException(String errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
        this.messageArgs = new Object[0];
        this.context = new HashMap<>();
    }
    
    public BusinessException(String errorCode, String message, Object... messageArgs) {
        super(message);
        this.errorCode = errorCode;
        this.messageArgs = messageArgs;
        this.context = new HashMap<>();
    }
    
    /**
     * 添加上下文信息
     * TODO: 使用Copilot实现流式API，方便添加异常上下文
     */
    public BusinessException addContext(String key, Object value) {
        // TODO: 实现上下文添加逻辑
        return this;
    }
    
    /**
     * 静态工厂方法
     * TODO: 使用Copilot生成常用业务异常的静态创建方法
     */
    public static BusinessException entityNotFound(String entityType, Object id) {
        // TODO: 实现资源未找到异常创建
    }
    
    public static BusinessException duplicateEntity(String entityType, String field, Object value) {
        // TODO: 实现重复资源异常创建
    }
    
    public static BusinessException businessRuleViolation(String rule, String message) {
        // TODO: 实现业务规则违反异常创建
    }
}
```

---

## 🧪 模板4：测试用例模板

### 单元测试模板

```java
/**
 * {服务类名}单元测试
 * 
 * 测试策略：
 * - 使用Mockito模拟依赖
 * - 覆盖正常流程、边界情况、异常情况
 * - 使用参数化测试提高覆盖率
 * - 验证方法调用和参数传递
 * - 断言使用AssertJ提高可读性
 * 
 * 测试环境：
 * - JUnit 5
 * - Mockito
 * - AssertJ
 * - TestContainers (集成测试)
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("{服务类名}单元测试")
class {ServiceClass}Test {
    
    @Mock
    private {EntityName}Repository repository;
    
    @Mock
    private {EntityName}Mapper mapper;
    
    @InjectMocks
    private {ServiceClass} service;
    
    @Nested
    @DisplayName("创建{实体名称}测试")
    class CreateTests {
        
        /**
         * 正常创建场景测试
         * TODO: 使用Copilot生成正常流程的测试用例
         * 包括：准备测试数据、Mock行为设置、方法调用、结果验证
         */
        @Test
        @DisplayName("正常创建{实体名称}")
        void shouldCreateEntitySuccessfully() {
            
            // TODO: 实现正常创建测试
            // Given - 准备测试数据
            // When - 执行被测方法
            // Then - 验证结果和交互
        }
        
        /**
         * 创建重复{实体名称}测试
         * TODO: 测试重复创建的异常处理
         */
        @Test
        @DisplayName("创建重复{实体名称}应抛出异常")
        void shouldThrowExceptionWhenCreateDuplicate() {
            
            // TODO: 实现重复创建异常测试
            // Given - 设置重复场景的Mock
            // When & Then - 验证异常抛出
        }
        
        /**
         * 参数化测试 - 验证不同的无效输入
         * TODO: 使用@ParameterizedTest测试多种无效参数
         */
        @ParameterizedTest
        @DisplayName("无效参数应抛出验证异常")
        @ValueSource(strings = {"", "   ", "null"})
        void shouldThrowValidationExceptionForInvalidInput(String invalidInput) {
            
            // TODO: 实现参数验证测试
        }
    }
    
    @Nested
    @DisplayName("查询{实体名称}测试")  
    class FindTests {
        
        /**
         * 按ID查询存在的{实体名称}
         */
        @Test
        @DisplayName("按ID查询存在的{实体名称}")
        void shouldFindEntityById() {
            
            // TODO: 实现查询存在记录的测试
        }
        
        /**
         * 按ID查询不存在的{实体名称}
         */
        @Test
        @DisplayName("按ID查询不存在的{实体名称}")
        void shouldReturnEmptyWhenEntityNotFound() {
            
            // TODO: 实现查询不存在记录的测试
        }
        
        /**
         * 分页查询测试
         */
        @Test
        @DisplayName("分页查询{实体名称}列表")
        void shouldFindEntitiesByPage() {
            
            // TODO: 实现分页查询测试
            // 验证分页参数、排序、过滤条件
        }
    }
    
    @Nested
    @DisplayName("更新{实体名称}测试")
    class UpdateTests {
        
        /**
         * 正常更新测试
         */
        @Test
        @DisplayName("正常更新{实体名称}")
        void shouldUpdateEntitySuccessfully() {
            
            // TODO: 实现正常更新测试
        }
        
        /**
         * 乐观锁冲突测试
         */
        @Test
        @DisplayName("并发更新应处理乐观锁冲突")
        void shouldHandleOptimisticLockException() {
            
            // TODO: 实现并发冲突测试
        }
    }
    
    @Nested
    @DisplayName("删除{实体名称}测试")
    class DeleteTests {
        
        /**
         * 软删除测试
         */
        @Test
        @DisplayName("软删除{实体名称}")
        void shouldSoftDeleteEntity() {
            
            // TODO: 实现软删除测试
        }
        
        /**
         * 删除不存在的{实体名称}测试
         */
        @Test
        @DisplayName("删除不存在的{实体名称}应抛出异常")
        void shouldThrowExceptionWhenDeleteNonExistentEntity() {
            
            // TODO: 实现删除不存在记录的异常测试
        }
    }
    
    /**
     * 测试数据工厂方法
     * TODO: 使用Copilot生成创建测试数据的工厂方法
     */
    private {EntityName} createTestEntity() {
        // TODO: 创建测试用的实体对象
    }
    
    private List<{EntityName}> createTestEntityList(int count) {
        // TODO: 创建测试用的实体列表
    }
    
    private {EntityName}CreateRequest createTestRequest() {
        // TODO: 创建测试用的请求对象
    }
}
```

### 集成测试模板

```java
/**
 * {服务类名}集成测试
 * 
 * 集成测试特点：
 * - 使用TestContainers启动真实数据库
 * - 测试完整的数据流转
 * - 验证事务行为
 * - 测试数据库约束和触发器
 * 
 * 环境配置：
 * - Spring Boot Test
 * - TestContainers
 * - 真实数据库环境
 */
@SpringBootTest
@Testcontainers
@Transactional
@Rollback
@DisplayName("{服务类名}集成测试")
class {ServiceClass}IntegrationTest {
    
    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:13")
            .withDatabaseName("test_db")
            .withUsername("test_user")
            .withPassword("test_pass");
    
    @Autowired
    private {ServiceClass} service;
    
    @Autowired
    private {EntityName}Repository repository;
    
    @Autowired
    private TestEntityManager entityManager;
    
    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
    }
    
    /**
     * 完整CRUD流程集成测试
     * TODO: 使用Copilot生成端到端的CRUD流程测试
     */
    @Test
    @DisplayName("完整CRUD流程测试")
    void shouldPerformCompleteEntityLifecycle() {
        
        // TODO: 实现完整的CRUD流程测试
        // 1. 创建实体
        // 2. 查询验证
        // 3. 更新实体
        // 4. 再次查询验证
        // 5. 删除实体
        // 6. 验证删除结果
    }
    
    /**
     * 事务回滚测试
     * TODO: 测试事务边界和回滚机制
     */
    @Test
    @DisplayName("异常时应回滚事务")
    void shouldRollbackTransactionOnException() {
        
        // TODO: 实现事务回滚测试
    }
    
    /**
     * 并发访问测试
     * TODO: 测试多线程并发访问数据库
     */
    @Test
    @DisplayName("并发访问测试")
    void shouldHandleConcurrentAccess() throws InterruptedException {
        
        // TODO: 实现并发访问测试
        // 使用CountDownLatch控制并发执行
    }
    
    /**
     * 性能基准测试
     * TODO: 测试大量数据操作的性能表现
     */
    @Test
    @DisplayName("批量操作性能测试")
    @Timeout(value = 30, unit = TimeUnit.SECONDS)
    void shouldPerformBatchOperationsWithinTimeLimit() {
        
        // TODO: 实现性能测试
        // 创建大量测试数据并验证执行时间
    }
}
```

### Mock测试数据生成模板

```java
/**
 * 测试数据生成工具类
 * 
 * 功能包括：
 * - 随机测试数据生成
 * - 符合业务规则的数据
 * - 支持不同场景的数据变体
 * - Mock外部服务响应
 */
@UtilityClass
public class {EntityName}TestDataFactory {
    
    private static final Faker faker = new Faker(Locale.CHINA);
    
    /**
     * 创建标准测试{实体名称}
     * TODO: 使用Copilot和Faker生成符合业务规则的测试数据
     */
    public static {EntityName} createStandardEntity() {
        // TODO: 生成标准的测试实体对象
        // 使用Faker生成真实感的随机数据
    }
    
    /**
     * 创建无效测试{实体名称}
     * TODO: 生成用于验证测试的无效数据
     */
    public static {EntityName} createInvalidEntity() {
        // TODO: 生成包含无效字段的测试对象
    }
    
    /**
     * 批量创建测试{实体名称}
     * TODO: 生成指定数量的测试实体列表
     */
    public static List<{EntityName}> createEntityList(int count) {
        // TODO: 生成测试实体列表，每个对象略有不同
    }
    
    /**
     * 创建特定场景的测试数据
     * TODO: 根据测试场景创建对应的数据
     */
    public static {EntityName} createEntityForScenario(String scenario) {
        // TODO: 根据场景名称生成相应的测试数据
        switch (scenario) {
            case "expired":
                // 生成过期的测试数据
            case "locked":
                // 生成锁定状态的测试数据
            case "pending":
                // 生成待处理状态的测试数据
            default:
                // 生成默认测试数据
        }
    }
}
```

---

## ⚡ 模板5：性能优化模板

### 数据库查询优化模板

```java
/**
 * {实体名称}数据访问优化服务
 * 
 * 性能优化策略：
 * 1. 查询优化 - 索引、分页、预加载
 * 2. 缓存策略 - 多级缓存、缓存穿透防护
 * 3. 批量处理 - 减少数据库往返次数
 * 4. 连接池优化 - 连接复用和超时控制
 * 5. 读写分离 - 查询负载均衡
 */
@Service
@Slf4j
public class {EntityName}PerformanceService {
    
    private final {EntityName}Repository repository;
    private final RedisTemplate<String, Object> redisTemplate;
    private final JdbcTemplate jdbcTemplate;
    
    // 缓存配置
    private static final String CACHE_PREFIX = "{entity_name}_cache:";
    private static final Duration CACHE_TTL = Duration.ofMinutes(30);
    
    /**
     * 高性能分页查询
     * 
     * 优化技术：
     * - 游标分页替代偏移分页
     * - 索引覆盖查询
     * - 结果集缓存
     * - 预加载关联数据
     * 
     * @param cursor 游标位置
     * @param size 页面大小
     * @param criteria 查询条件
     * @return 查询结果
     */
    public CursorPage<{EntityName}> findByPageOptimized(String cursor, int size, 
                                                        {EntityName}SearchCriteria criteria) {
        
        // TODO: 使用Copilot实现高性能分页查询
        // 1. 构建游标查询条件（避免OFFSET性能问题）
        // 2. 使用索引覆盖查询减少回表
        // 3. 预加载必要的关联数据
        // 4. 缓存热点查询结果
        // 5. 返回带有下一页游标的结果
    }
    
    /**
     * 批量查询优化
     * 
     * 解决N+1查询问题：
     * - 使用EntityGraph预加载
     * - 批量查询关联数据
     * - IN查询替代多次单查
     * 
     * @param ids ID列表
     * @return 实体列表
     */
    @Cacheable(value = "entityBatch", key = "#ids.hashCode()")
    public List<{EntityName}> findByIdsOptimized(List<Long> ids) {
        
        // TODO: 实现批量查询优化
        // 1. ID去重和分批处理
        // 2. 使用EntityGraph或FetchJoin预加载关联
        // 3. 单次查询获取所有关联数据
        // 4. 结果按原始ID顺序排序
        // 5. 缓存查询结果
    }
    
    /**
     * 复杂统计查询优化
     * 
     * 优化策略：
     * - 使用原生SQL避免ORM开销
     * - 利用数据库聚合函数
     * - 结果缓存和定时刷新
     * - 读写分离到只读实例
     * 
     * @param criteria 统计条件
     * @return 统计结果
     */
    @Cacheable(value = "statistics", key = "#criteria.cacheKey()")
    public {EntityName}Statistics getStatisticsOptimized({EntityName}StatisticsCriteria criteria) {
        
        // TODO: 实现复杂统计查询优化
        // 1. 构建优化的原生SQL查询
        // 2. 使用数据库视图或物化视图
        // 3. 并行查询不同的统计维度
        // 4. 结果聚合和缓存
        // 5. 异步更新缓存策略
    }
    
    /**
     * 大批量数据导入优化
     * 
     * 性能优化：
     * - JDBC批处理
     * - 事务批次控制
     * - 临时禁用索引/触发器
     * - 并行处理
     * 
     * @param dataList 待导入数据
     * @param batchSize 批次大小
     * @return 导入结果
     */
    public BatchImportResult bulkImportOptimized(List<{EntityName}> dataList, int batchSize) {
        
        // TODO: 实现大批量导入优化
        // 1. 数据预处理和验证
        // 2. 分批次事务处理
        // 3. 使用JDBC批处理提高性能
        // 4. 并行处理多个批次
        // 5. 进度跟踪和错误恢复
    }
    
    /**
     * 热点数据缓存策略
     * 
     * 缓存层级：
     * - L1: 本地缓存 (Caffeine)
     * - L2: Redis集中缓存
     * - L3: 数据库结果集缓存
     * 
     * @param id 实体ID
     * @return 缓存的实体对象
     */
    public Optional<{EntityName}> findByIdWithMultiLevelCache(Long id) {
        
        // TODO: 实现多级缓存查询
        // 1. 检查本地缓存 (L1)
        // 2. 检查Redis缓存 (L2)
        // 3. 查询数据库并更新缓存
        // 4. 实现缓存预热机制
        // 5. 处理缓存穿透和雪崩
    }
    
    /**
     * 数据库连接池监控和优化
     * 
     * 监控指标：
     * - 连接池使用率
     * - 平均等待时间
     * - 查询执行时间
     * - 慢查询统计
     * 
     * @return 数据库性能指标
     */
    @Scheduled(fixedRate = 60000) // 每分钟执行一次
    public void monitorDatabasePerformance() {
        
        // TODO: 实现数据库性能监控
        // 1. 收集连接池统计信息
        // 2. 分析慢查询日志
        // 3. 监控数据库负载指标
        // 4. 发送性能告警
        // 5. 自动优化建议生成
    }
}
```

### 缓存优化模板

```java
/**
 * 缓存管理服务
 * 
 * 缓存策略：
 * - 分布式缓存一致性
 * - 缓存雪崩防护
 * - 缓存穿透防护
 * - 缓存热点检测
 * - 智能缓存预热
 */
@Service
@Slf4j
public class CacheOptimizationService {
    
    private final RedisTemplate<String, Object> redisTemplate;
    private final RedissonClient redissonClient;
    
    /**
     * 防缓存击穿的查询方法
     * 
     * 保护机制：
     * - 分布式锁防止并发击穿
     * - 空值缓存防止穿透
     * - 随机TTL防止雪崩
     * - 热点数据永不过期
     * 
     * @param key 缓存键
     * @param supplier 数据加载器
     * @param ttl 过期时间
     * @return 缓存数据
     */
    public <T> Optional<T> getWithProtection(String key, Supplier<Optional<T>> supplier, Duration ttl) {
        
        // TODO: 使用Copilot实现防击穿缓存查询
        // 1. 检查缓存是否命中
        // 2. 缓存未命中时获取分布式锁
        // 3. 双重检查避免重复查询
        // 4. 加载数据并更新缓存
        // 5. 释放锁并返回结果
    }
    
    /**
     * 智能缓存预热
     * 
     * 预热策略：
     * - 基于访问频率的热点数据识别
     * - 定时批量预热
     * - 渐进式预热避免系统冲击
     * - 预热失败重试机制
     * 
     * @param category 预热分类
     */
    @Async("cacheWarmupExecutor")
    public CompletableFuture<Void> smartWarmup(String category) {
        
        // TODO: 实现智能缓存预热
        // 1. 分析访问模式识别热点数据
        // 2. 分批次预热避免系统冲击
        // 3. 预热进度跟踪和监控
        // 4. 失败重试和降级策略
        // 5. 预热效果评估
    }
    
    /**
     * 缓存一致性管理
     * 
     * 一致性策略：
     * - 写操作时主动失效
     * - 基于版本的一致性检查
     * - 延迟双删策略
     * - 分布式事务一致性
     * 
     * @param pattern 缓存键模式
     */
    public void invalidateByPattern(String pattern) {
        
        // TODO: 实现批量缓存失效
        // 1. 使用Lua脚本原子性删除
        // 2. 支持通配符模式匹配
        // 3. 分布式环境下的一致性保证
        // 4. 失效操作日志记录
        // 5. 失效通知和监控
    }
}
```

### 异步处理优化模板

```java
/**
 * 异步处理优化服务
 * 
 * 异步场景：
 * - 大数据量处理
 * - 长时间运行任务
 * - 系统解耦
 * - 提升用户体验
 */
@Service
@Slf4j
public class AsyncProcessingService {
    
    private final TaskExecutor taskExecutor;
    private final RabbitTemplate rabbitTemplate;
    
    /**
     * 异步批量处理
     * 
     * 优化策略：
     * - 数据分片并行处理
     * - 线程池优化配置
     * - 进度跟踪和通知
     * - 失败重试机制
     * 
     * @param request 批量处理请求
     * @return 处理任务ID
     */
    @Async("batchProcessExecutor")
    public CompletableFuture<BatchProcessResult> processBatchAsync(BatchProcessRequest request) {
        
        // TODO: 使用Copilot实现异步批量处理
        // 1. 数据分片策略
        // 2. 并行处理协调
        // 3. 进度跟踪更新
        // 4. 异常处理和重试
        // 5. 结果汇总和通知
    }
    
    /**
     * 消息队列异步处理
     * 
     * 队列优化：
     * - 消息持久化和确认
     * - 死信队列处理
     * - 消费者动态扩缩容
     * - 消息去重和幂等
     * 
     * @param message 异步消息
     */
    @RabbitListener(queues = "{entity.name}.process.queue")
    public void handleAsyncMessage(@Payload {EntityName}ProcessMessage message) {
        
        // TODO: 实现消息队列异步处理
        // 1. 消息验证和解析
        // 2. 幂等性检查
        // 3. 业务逻辑处理
        // 4. 结果通知
        // 5. 异常处理和重试
    }
    
    /**
     * 流式数据处理
     * 
     * 流处理特性：
     * - 实时数据流处理
     * - 背压控制
     * - 数据转换管道
     * - 错误处理策略
     * 
     * @param dataStream 数据流
     * @return 处理结果流
     */
    public Flux<ProcessedResult> processStreamData(Flux<RawData> dataStream) {
        
        // TODO: 实现流式数据处理
        // 1. 数据流转换管道
        // 2. 背压处理策略
        // 3. 并行处理优化
        // 4. 错误恢复机制
        // 5. 处理进度监控
    }
}
```

---

## 📖 使用指南

### 模板使用步骤

1. **选择合适的模板**：根据开发需求选择对应的模板分类
2. **替换占位符**：将模板中的 `{EntityName}`、`{ServiceClass}` 等占位符替换为实际的类名
3. **完善TODO注释**：根据具体业务需求补充详细的TODO注释
4. **使用Copilot生成**：将带有详细注释的模板交给Copilot生成具体实现
5. **代码审查优化**：对生成的代码进行人工审查和优化调整

### 团队协作建议

1. **统一代码风格**：团队成员使用相同的模板确保代码一致性
2. **模板版本管理**：将模板文件纳入版本控制，定期更新和改进
3. **最佳实践分享**：收集团队使用经验，持续优化模板质量
4. **培训和指导**：为新成员提供模板使用培训，提高开发效率

### 注意事项

- ⚠️ **安全审查**：对AI生成的代码要进行安全审查，特别是涉及数据库操作和用户输入的部分
- 🔍 **性能测试**：使用性能优化模板时，需要进行实际的性能测试验证效果
- 📝 **文档维护**：及时更新模板文档，反映最新的技术栈和最佳实践
- 🧪 **充分测试**：使用测试模板生成的测试用例要覆盖业务的各种场景

---

**通过这套Java提示词模板库，团队可以显著提高开发效率，保证代码质量的一致性，让AI成为真正的编程助手！** 🚀
