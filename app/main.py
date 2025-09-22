from flask import Blueprint, render_template, jsonify, current_app

bp = Blueprint("main", __name__)

@bp.route("/")
def index():
    # Get light state from app config
    light = current_app.config.get("LIGHT_STATE", False)
    return render_template("index.html", light=light)

@bp.route("/toggle", methods=["POST"])
def toggle():
    # Toggle light state in app config
    current_state = current_app.config.get("LIGHT_STATE", False)
    new_state = not current_state
    current_app.config["LIGHT_STATE"] = new_state
    return jsonify({"light": new_state})
