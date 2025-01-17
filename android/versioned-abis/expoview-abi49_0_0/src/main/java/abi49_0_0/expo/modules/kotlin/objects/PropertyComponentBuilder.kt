@file:OptIn(ExperimentalStdlibApi::class)

package abi49_0_0.expo.modules.kotlin.objects

import abi49_0_0.expo.modules.kotlin.functions.SyncFunctionComponent
import abi49_0_0.expo.modules.kotlin.types.toAnyType
import kotlin.reflect.typeOf

class PropertyComponentBuilder(
  val name: String
) {
  var getter: SyncFunctionComponent? = null
  var setter: SyncFunctionComponent? = null

  /**
   * Modifier that sets property getter that has no arguments (the caller is not used).
   */
  inline fun <T> get(crossinline body: () -> T) = apply {
    getter = SyncFunctionComponent("get", arrayOf()) { body() }
  }

  /**
   * Modifier that sets property setter that receives only the new value as an argument.
   */
  inline fun <reified T> set(crossinline body: (newValue: T) -> Unit) = apply {
    setter = SyncFunctionComponent("set", arrayOf(typeOf<T>().toAnyType())) { body(it[0] as T) }
  }

  fun build(): PropertyComponent {
    return PropertyComponent(name, getter, setter)
  }
}
