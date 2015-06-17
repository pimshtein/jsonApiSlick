package models

import org.joda.time.LocalDate
import play.api.libs.json._

case class User(id: Int, name: String, patronymic: String, surname: String,
                address: String, dob: LocalDate, sex: Int, fill: BigDecimal)

object Person {
  implicit val userFormat = Json.format[User]
}
