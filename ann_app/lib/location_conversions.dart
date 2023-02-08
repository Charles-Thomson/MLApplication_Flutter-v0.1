// Find the size of each state on the board (x,y)
List<double> sizeOfStates(
    double statesX, double statesY, double mazeSizeX, double mazeSizeY) {
  double stateSizeX = double.parse((mazeSizeX / statesX).toStringAsFixed(2));
  double stateSizeY = double.parse((mazeSizeY / statesY).toStringAsFixed(2));
  return [stateSizeX, stateSizeY];
}

// Conver the state to the (x,y) coords on the board
List<double> stateToBoardLocation(
    double stateSizeX, double stateSizeY, double totalStateCols, double state) {
  double yLocationInStates = state.remainder(totalStateCols);
  double xLocationInStates = (state / totalStateCols).floorToDouble();

  double boardLocationX = stateSizeX * xLocationInStates;
  double boardLocationY = stateSizeY * yLocationInStates;
  return [boardLocationX, boardLocationY];
}
