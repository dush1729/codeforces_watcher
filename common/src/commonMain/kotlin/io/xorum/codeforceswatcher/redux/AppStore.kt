package io.xorum.codeforceswatcher.redux

import com.squareup.sqldelight.db.SqlDriver
import io.xorum.codeforceswatcher.db.DatabaseController
import io.xorum.codeforceswatcher.redux.middlewares.appMiddleware
import io.xorum.codeforceswatcher.redux.middlewares.notificationMiddleware
import io.xorum.codeforceswatcher.redux.middlewares.toastMiddleware
import io.xorum.codeforceswatcher.redux.reducers.appReducer
import io.xorum.codeforceswatcher.util.PersistenceController
import tw.geothings.rekotlin.Store

lateinit var sqlDriver: SqlDriver
val localizedStrings: MutableMap<String, String> = mutableMapOf()

val persistenceController = PersistenceController()
val databaseController = DatabaseController()

val store by lazy {
    Store(
            reducer = ::appReducer,
            state = databaseController.fetchAppState(),
            middleware = listOf(appMiddleware, notificationMiddleware, toastMiddleware)
    )
}
