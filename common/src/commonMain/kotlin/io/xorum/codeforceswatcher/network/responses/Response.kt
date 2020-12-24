package io.xorum.codeforceswatcher.network.responses

sealed class Response<T> {

    data class Success<T>(
            val result: T
    ) : Response<T>()

    data class Failure<T>(
            val error: String?
    ) : Response<T>()
}