# Sample of repository layer

## Concepts

- Abstracts API request.
- Manages global stream.
- Rx-based reactive architecture.
- Easy to mock.
- Protocol oriented.

## Units

### ResponseDefinition (protocol)

- Defines structure of response.
- Single element, array element and empty response are supported.

_See also: SingleResponse, ArrayResponse, EmptyResponse_

#### Requirements

##### `associatedtype Result`

Type of element in response.

##### `var result: Result`

Actual element of response.

##### `init(json: Any) throws`

Initializes response from API response JSON.

- json: Any
    - JSON dictionary or array returned by API

### SingleResponse<T: Decodable>

- Conforms to `ResponseDefinition`.
- Means the response contains simgle element of `T`.
- Type of `result` is `T`.

### ArrayResponse<T: Decodeble>

- Conforms to `ResponseDefinition`
- Means the response contains multiple element of `T`
- Type of `result` is `[T]`

### EmptyResponse

- Conforms to `ResponseDefinition`
- Means the response does not contain any element.
- Type of `result` is `Void`.

### EndpointDefinition (protocol)

- Defines API endpoints.
- Equivalent to API documentation.

#### Requirements

##### `associatedtype Response: ResponseDefinition`

Indicates type of API response.

Ex:

```swift
typealias Response = ArrayResponse<User>
```

##### `static var path: String`

Path of endpoint.

Ex: 

```swift
static var path: String = "/user/following"
```

##### `static var environment: Environment`

This property is used to switch environment partially. Default value is `.production`.  
If you want to use other environment with only specific endpoint, you can override this property with value `.mock` or `.staging`.

##### `var parameters: [String: Any]`

Parameters to use in request. Default value is `[:]`.

##### `var method: HTTPMethod`

Method to use in request.

### `Endpoint`

Namespace to define endpoints which conforms to `EndpointDefinition`.

### `GenericRequest<Endpoint: EndpointDefinition>`

Creates request object for APIKit with `EndpointDefinition`.  
You do not have to create GenericRequest object manually.

### `Repository`

Defines interface for higher-layer components such as ViewModels.