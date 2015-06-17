package controllers

import dao.UserDAO
import javax.inject.Inject
import play.api.mvc.Action
import play.api.mvc.Controller
import play.api.libs.json._

class Application @Inject()(userDao: UserDAO) extends Controller {

  def index = Action {
    Ok(views.html.index("It's test."))
  }

  def getUsers = Action.async {
    userDao.list().map { User =>
      Ok(Json.toJson(User))
    }
  }

}
