package com.bogdan.codeforceswatcher.redux

import org.rekotlin.Middleware
import org.rekotlin.StateType

val appMiddleware: Middleware<StateType> = { _, _ ->
    { next ->
        { action ->
            (action as? Request)?.execute()
            next(action)
        }
    }
}
