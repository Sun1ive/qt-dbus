function getNmColor(value) {
    var color;

    switch (+value) {
    case 20:
        color = "red"
        break;
    case 40:
        color = "yellow"
        break;
    case 60:
        color = "yellow"
        break;
    case 70:
        color = "green"
        break;
    default:
        color = "#000";
        break;
    }

    return color;
}
