package controllers

import dao._
import models._
import play.api.mvc.Action
import play.api._
import play.api.mvc._
import play.api.i18n._
import play.api.libs.json.Json
import scala.concurrent.{ ExecutionContext, Future }

import javax.inject._

class Application @Inject()(userDao: UserDAO, val messagesApi: MessagesApi)
                           (implicit ec: ExecutionContext) extends Controller  with I18nSupport {

  def index = Action {
    Ok(views.html.index("It's test."))
  }

  def getUsers = Action.async {
    userDao.list().map { Users =>
      Ok(Json.toJson(Users))
    }
  }

}
