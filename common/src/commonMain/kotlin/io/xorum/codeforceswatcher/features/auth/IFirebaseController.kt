package io.xorum.codeforceswatcher.features.auth

interface IFirebaseController {

    fun signIn(email: String, password: String, callback: (Exception?) -> Unit)

    fun signUp(email: String, password: String, callback: (Exception?) -> Unit)

    fun fetchToken(callback: (String?, Exception?) -> Unit)

    fun logOut(callback: (Exception?) -> Unit)

    fun sendPasswordReset(email: String, callback: (Exception?) -> Unit)
}