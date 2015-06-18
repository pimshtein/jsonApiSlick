package dao

import org.joda.time.format.DateTimeFormat
import javax.inject.{ Inject, Singleton }
import models.User
import org.joda.time.LocalDate
import play.api.db.slick.DatabaseConfigProvider
import slick.driver.JdbcProfile
import scala.concurrent.{ Future, ExecutionContext }

@Singleton
class UserDAO @Inject()(dbConfigProvider: DatabaseConfigProvider)(implicit ec: ExecutionContext) {

  private val dbConfig = dbConfigProvider.get[JdbcProfile]
  import dbConfig._
  import driver.api._

  private val Users = TableQuery[UsersTable]

  //def all(): Future[Seq[User]] = db.run(Users.result)

  //def insert(user: User): Future[Unit] = db.run(Users += user).map { _ => () }

  private class UsersTable(tag: Tag) extends Table[User](tag, "user") {

    val dateFormatter = DateTimeFormat.forPattern("yyyy-MM-dd")
    implicit val dateColumnType = MappedColumnType.base[LocalDate, String]({ dateFormatter.print(_) }, { dateFormatter.parseLocalDate })
    def id = column[Int]("id", O.PrimaryKey, O.AutoInc)
    def name = column[String]("name", O.SqlType("VARCHAR(255)"))
    def patronymic = column[String]("patronymic", O.SqlType("VARCHAR(255)"))
    def surname = column[String]("surname", O.SqlType("VARCHAR(255)"))
    def address = column[String]("address", O.SqlType("TEXT"))
    def dob = column[LocalDate]("dob", O.SqlType("DATE"))
    def sex = column[Int]("sex", O.SqlType("TINYINT"))
    def fill = column[BigDecimal]("fill", O.SqlType("DECIMAL(5, 2)"))

    def * = (id, name, patronymic, surname, address, dob, sex, fill) <> ((User.apply _).tupled, User.unapply)
  }

  /**
   * List all the users in the database.
   */
  def list(): Future[Seq[User]] = db.run {
    Users.result
  }
}
