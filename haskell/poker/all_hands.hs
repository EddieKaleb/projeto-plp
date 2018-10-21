module AllHands where

getHands :: [String]
getHands = [
  "AA,85.3,73.4,63.9,55.9,49.2,43.6,38.8,34.7,31.1",
  "Ks,67.0,50.7,41.4,35.4,31.1,27.7,25.0,22.7,20.7",
  "Ko,65.4,48.2,38.6,32.4,27.9,24.4,21.6,19.2,17.2",
  "Qs,66.1,49.4,39.9,33.7,29.4,26.0,23.3,21.1,19.3",
  "Qo,64.5,46.8,36.9,30.4,25.9,22.5,19.7,17.5,15.5",
  "Js,65.4,48.2,38.5,32.2,27.8,24.5,22.0,19.9,18.1",
  "Jo,63.6,45.6,35.4,28.9,24.4,21.0,18.3,16.1,14.3",
  "Ts,64.7,47.1,37.2,31.0,26.7,23.5,21.0,18.9,17.3",
  "To,62.9,44.4,34.1,27.6,23.1,19.8,17.2,15.1,13.4",
  "9s,63.0,44.8,34.6,28.4,24.2,21.1,18.8,16.9,15.4",
  "9o,60.9,41.8,31.2,24.7,20.3,17.1,14.7,12.8,11.2",
  "8s,62.1,43.7,33.6,27.4,23.3,20.3,18.0,16.2,14.8",
  "8o,60.1,40.8,30.1,23.7,19.4,16.2,13.9,12.0,10.6",
  "7s,61.1,42.6,32.6,26.5,22.5,19.6,17.4,15.7,14.3",
  "7o,59.1,39.4,28.9,22.6,18.4,15.4,13.2,11.4,10.1",
  "6s,60.0,41.3,31.4,25.6,21.7,19.0,16.9,15.3,14.0",
  "6o,57.8,38.0,27.6,21.5,17.5,14.7,12.6,10.9,9.6",
  "5s,59.9,41.4,31.8,26.0,22.2,19.6,17.5,15.9,14.5",
  "5o,57.7,38.2,27.9,22.0,18.0,15.2,13.1,11.5,10.1",
  "4s,58.9,40.4,30.9,25.3,21.6,19.0,17.0,15.5,14.2",
  "4o,56.4,36.9,26.9,21.1,17.3,14.7,12.6,11.0,9.8",
  "3s,58.0,39.4,30.0,24.6,21.0,18.5,16.6,15.1,13.9",
  "3o,55.6,35.9,26.1,20.4,16.7,14.2,12.2,10.7,9.5",
  "2s,57.0,38.5,29.2,23.9,20.4,18.0,16.1,14.6,13.4",
  "2o,54.6,35.0,25.2,19.6,16.1,13.6,11.7,10.2,9.1",
  "K,82.4,68.9,58.2,49.8,43.0,37.5,32.9,29.2,26.1",
  "Qs,63.4,47.1,38.2,32.5,28.3,25.1,22.5,20.4,18.6",
  "Qo,61.4,44.4,35.2,29.3,25.1,21.8,19.1,16.9,15.1",
  "Js,62.6,45.9,36.8,31.1,26.9,23.8,21.3,19.3,17.6",
  "Jo,60.6,43.1,33.6,27.6,23.5,20.2,17.7,15.6,13.9",
  "Ts,61.9,44.9,35.7,29.9,25.8,22.8,20.4,18.5,16.9",
  "To,59.9,42.0,32.5,26.5,22.3,19.2,16.7,14.7,13.1",
  "9s,60.0,42.4,32.9,27.2,23.2,20.3,18.1,16.3,14.8",
  "9o,58.0,39.5,29.6,23.6,19.5,16.5,14.1,12.3,10.8",
  "8s,58.5,40.2,30.8,25.1,21.3,18.6,16.5,14.8,13.5",
  "8o,56.3,37.2,27.3,21.4,17.4,14.6,12.5,10.8,9.4",
  "7s,57.8,39.4,30.1,24.5,20.8,18.1,16.0,14.5,13.2",
  "7o,55.4,36.1,26.3,20.5,16.7,13.9,11.8,10.2,9.0",
  "6s,56.8,38.4,29.1,23.7,20.1,17.5,15.6,14.0,12.8",
  "6o,54.3,35.0,25.3,19.7,16.0,13.3,11.3,9.8,8.6",
  "5s,55.8,37.4,28.2,23.0,19.5,17.0,15.2,13.7,12.5",
  "5o,53.3,34.0,24.5,19.0,15.4,12.9,11.0,9.5,8.3",
  "4s,54.7,36.4,27.4,22.3,19.0,16.6,14.8,13.4,12.3",
  "4o,52.1,32.8,23.4,18.1,14.7,12.3,10.5,9.1,8.0",
  "3s,53.8,35.5,26.7,21.7,18.4,16.2,14.5,13.1,12.1",
  "3o,51.2,31.9,22.7,17.6,14.2,11.9,10.2,8.9,7.8",
  "2s,52.9,34.6,26.0,21.2,18.1,15.9,14.3,13.0,11.9",
  "2o,50.2,30.9,21.8,16.9,13.7,11.5,9.8,8.6,7.6",
  "Q,79.9,64.9,53.5,44.7,37.9,32.5,28.3,24.9,22.2",
  "Js,60.3,44.1,35.6,30.1,26.1,23.0,20.7,18.7,17.1",
  "Jo,58.2,41.4,32.6,26.9,22.9,19.8,17.3,15.3,13.7",
  "Ts,59.5,43.1,34.6,29.1,25.2,22.3,19.9,18.1,16.6",
  "To,57.4,40.2,31.3,25.7,21.6,18.6,16.3,14.4,12.9",
  "9s,57.9,40.7,31.9,26.4,22.5,19.7,17.6,15.9,14.5",
  "9o,55.5,37.6,28.5,22.9,19.0,16.1,13.8,12.1,10.7",
  "8s,56.2,38.6,29.7,24.4,20.7,18.0,16.0,14.4,13.2",
  "8o,53.8,35.4,26.2,20.6,16.9,14.1,12.1,10.5,9.2",
  "7s,54.5,36.7,27.9,22.7,19.2,16.7,14.8,13.3,12.1",
  "7o,51.9,33.2,24.0,18.6,15.1,12.5,10.6,9.2,8.0",
  "6s,53.8,35.8,27.1,21.9,18.5,16.1,14.3,12.9,11.7",
  "6o,51.1,32.3,23.2,17.9,14.4,12.0,10.1,8.8,7.6",
  "5s,52.9,34.9,26.3,21.4,18.1,15.8,14.1,12.7,11.6",
  "5o,50.2,31.3,22.3,17.3,13.9,11.6,9.8,8.5,7.4",
  "4s,51.7,33.9,25.5,20.7,17.6,15.4,13.7,12.4,11.3",
  "4o,49.0,30.2,21.4,16.4,13.3,11.0,9.4,8.1,7.1",
  "3s,50.7,33.0,24.7,20.1,17.0,14.9,13.3,12.1,11.1",
  "3o,47.9,29.2,20.7,15.9,12.8,10.7,9.1,7.9,6.9",
  "2s,49.9,32.2,24.0,19.5,16.6,14.6,13.1,11.9,10.9",
  "2o,47.0,28.4,19.9,15.3,12.3,10.3,8.8,7.7,6.8",
  "J,77.5,61.2,49.2,40.3,33.6,28.5,24.6,21.6,19.3",
  "Ts,57.5,41.9,33.8,28.5,24.7,21.9,19.7,17.9,16.5",
  "To,55.4,39.0,30.7,25.3,21.5,18.6,16.3,14.5,13.1",
  "9s,55.8,39.6,31.3,26.1,22.4,19.7,17.6,15.9,14.6",
  "9o,53.4,36.5,27.9,22.5,18.7,15.9,13.8,12.1,10.8",
  "8s,54.2,37.5,29.1,24.0,20.5,17.9,15.9,14.4,13.2",
  "8o,51.7,34.2,25.6,20.4,16.8,14.1,12.2,10.7,9.5",
  "7s,52.4,35.4,27.1,22.2,18.9,16.4,14.6,13.2,12.0",
  "7o,49.9,32.1,23.5,18.3,14.9,12.4,10.6,9.2,8.1",
  "6s,50.8,33.6,25.4,20.6,17.4,15.2,13.5,12.1,11.1",
  "6o,47.9,29.8,21.4,16.5,13.2,11.0,9.3,8.0,7.0",
  "5s,50.0,32.8,24.7,20.0,17.0,14.7,13.1,11.8,10.8",
  "5o,47.1,29.1,20.7,15.9,12.8,10.6,8.9,7.7,6.7",
  "4s,49.0,31.8,24.0,19.4,16.4,14.3,12.8,11.5,10.6",
  "4o,46.1,28.1,19.9,15.3,12.3,10.2,8.6,7.5,6.5",
  "3s,47.9,30.9,23.2,18.8,16.0,14.0,12.5,11.3,10.4",
  "3o,45.0,27.1,19.1,14.6,11.7,9.8,8.3,7.2,6.3",
  "2s,47.1,30.1,22.6,18.3,15.6,13.7,12.2,11.1,10.2",
  "2o,44.0,26.2,18.4,14.1,11.3,9.4,8.0,7.0,6.2",
  "T,75.1,57.7,45.2,36.4,30.0,25.3,21.8,19.2,17.2",
  "9s,54.3,38.9,31.0,26.0,22.5,19.8,17.8,16.2,14.9",
  "9o,51.7,35.7,27.7,22.5,18.9,16.2,14.1,12.6,11.3",
  "8s,52.6,36.9,29.0,24.0,20.6,18.1,16.2,14.8,13.6",
  "8o,50.0,33.6,25.4,20.4,16.9,14.4,12.5,11.0,9.9",
  "7s,51.0,34.9,27.0,22.2,19.0,16.6,14.8,13.5,12.4",
  "7o,48.2,31.4,23.4,18.4,15.1,12.8,11.0,9.7,8.6",
  "6s,49.2,32.8,25.1,20.5,17.4,15.2,13.6,12.3,11.2",
  "6o,46.3,29.2,21.2,16.5,13.4,11.2,9.5,8.3,7.3",
  "5s,47.2,30.8,23.3,18.9,16.0,13.9,12.4,11.2,10.2",
  "5o,44.2,27.1,19.3,14.8,11.9,9.9,8.4,7.2,6.4",
  "4s,46.4,30.1,22.7,18.4,15.6,13.6,12.1,11.0,10.0",
  "4o,43.4,26.4,18.7,14.3,11.5,9.5,8.1,7.0,6.2",
  "3s,45.5,29.3,22.0,17.8,15.1,13.2,11.8,10.7,9.8",
  "3o,42.4,25.5,18.0,13.7,11.0,9.1,7.8,6.8,6.0",
  "2s,44.7,28.5,21.4,17.4,14.8,13.0,11.6,10.5,9.7",
  "2o,41.5,24.7,17.3,13.2,10.6,8.8,7.5,6.6,5.8",
  "9,72.1,53.5,41.1,32.6,26.6,22.4,19.4,17.2,15.6",
  "8s,51.1,36.0,28.5,23.6,20.2,17.8,15.9,14.5,13.4",
  "8o,48.4,32.9,25.1,20.1,16.6,14.2,12.3,10.9,9.9",
  "7s,49.5,34.2,26.8,22.1,18.9,16.6,14.9,13.6,12.5",
  "7o,46.7,30.9,23.1,18.4,15.1,12.8,11.1,9.8,8.8",
  "6s,47.7,32.3,24.9,20.4,17.4,15.3,13.7,12.4,11.4",
  "6o,44.9,28.8,21.2,16.6,13.5,11.4,9.8,8.7,7.8",
  "5s,45.9,30.4,23.2,18.8,16.0,13.9,12.4,11.3,10.3",
  "5o,42.9,26.7,19.2,14.8,12.0,10.0,8.5,7.4,6.6",
  "4s,43.8,28.4,21.3,17.3,14.6,12.7,11.3,10.3,9.4",
  "4o,40.7,24.6,17.3,13.2,10.5,8.7,7.3,6.4,5.6",
  "3s,43.2,27.8,20.8,16.8,14.3,12.5,11.1,10.1,9.2",
  "3o,39.9,23.9,16.7,12.7,10.1,8.3,7.1,6.1,5.4",
  "2s,42.3,27.0,20.2,16.4,13.9,12.2,10.9,9.9,9.1",
  "2o,38.9,22.9,16.0,12.1,9.6,8.0,6.8,5.9,5.2",
  "8,69.1,49.9,37.5,29.4,24.0,20.3,17.7,15.8,14.4",
  "7s,48.2,33.9,26.6,22.0,18.9,16.7,15.0,13.7,12.7",
  "7o,45.5,30.6,23.2,18.5,15.4,13.1,11.5,10.3,9.3",
  "6s,46.5,32.0,25.0,20.6,17.6,15.6,14.1,12.9,11.9",
  "6o,43.6,28.6,21.3,16.9,13.9,11.8,10.4,9.2,8.3",
  "5s,44.8,30.2,23.2,19.1,16.3,14.3,12.9,11.8,10.9",
  "5o,41.7,26.5,19.4,15.2,12.4,10.5,9.1,8.1,7.3",
  "4s,42.7,28.1,21.4,17.4,14.8,13.0,11.7,10.6,9.8",
  "4o,39.6,24.4,17.5,13.4,10.8,9.0,7.8,6.8,6.1",
  "3s,40.8,26.3,19.8,16.0,13.6,11.9,10.7,9.7,8.9",
  "3o,37.5,22.4,15.7,11.9,9.5,7.9,6.7,5.8,5.1",
  "2s,40.3,25.8,19.4,15.7,13.3,11.7,10.5,9.6,8.8",
  "2o,36.8,21.7,15.1,11.4,9.1,7.5,6.4,5.6,4.9",
  "7,66.2,46.4,34.4,26.8,21.9,18.6,16.4,14.8,13.7",
  "6s,45.7,32.0,25.1,20.8,18.0,15.9,14.4,13.2,12.3",
  "6o,42.7,28.5,21.5,17.1,14.2,12.2,10.8,9.6,8.8",
  "5s,43.8,30.1,23.4,19.4,16.7,14.8,13.4,12.3,11.4",
  "5o,40.8,26.5,19.7,15.5,12.8,11.0,9.7,8.7,7.9",
  "4s,41.8,28.2,21.7,17.9,15.3,13.5,12.2,11.2,10.4",
  "4o,38.6,24.5,17.9,13.9,11.4,9.7,8.5,7.6,6.8",
  "3s,40.0,26.3,20.0,16.4,14.0,12.3,11.1,10.1,9.3",
  "3o,36.6,22.4,16.0,12.3,9.9,8.4,7.2,6.4,5.7",
  "2s,38.1,24.5,18.4,15.0,12.8,11.2,10.1,9.2,8.5",
  "2o,34.6,20.4,14.2,10.7,8.6,7.2,6.1,5.4,4.8",
  "6,63.3,43.2,31.5,24.5,20.1,17.3,15.4,14.0,13.1",
  "5s,43.2,30.2,23.7,19.7,17.0,15.2,13.8,12.7,11.9",
  "5o,40.1,26.7,20.0,15.9,13.3,11.5,10.2,9.2,8.5",
  "4s,41.4,28.5,22.1,18.4,15.9,14.2,12.9,11.9,11.1",
  "4o,38.0,24.7,18.2,14.4,12.0,10.3,9.2,8.3,7.6",
  "3s,39.4,26.5,20.4,16.8,14.5,12.9,11.7,10.8,10.0",
  "3o,35.9,22.7,16.4,12.8,10.6,9.1,8.0,7.2,6.5",
  "2s,37.5,24.8,18.8,15.4,13.3,11.8,10.7,9.8,9.1",
  "2o,34.0,20.7,14.6,11.2,9.1,7.8,6.8,6.0,5.4",
  "5,60.3,40.1,28.8,22.4,18.5,16.0,14.4,13.2,12.3",
  "4s,41.1,28.8,22.6,18.9,16.5,14.8,13.5,12.5,11.7",
  "4o,37.9,25.2,18.8,15.0,12.6,11.0,9.8,8.9,8.2",
  "3s,39.3,27.1,21.1,17.5,15.2,13.7,12.5,11.6,10.8",
  "3o,35.8,23.3,17.1,13.6,11.4,9.9,8.8,8.0,7.3",
  "2s,37.5,25.3,19.5,16.1,14.0,12.5,11.4,10.6,9.8",
  "2o,33.9,21.3,15.3,12.0,10.0,8.6,7.6,6.8,6.2",
  "4,57.0,36.8,26.3,20.6,17.3,15.2,13.9,12.9,12.1",
  "3s,38.0,26.2,20.3,16.9,14.7,13.1,12.0,11.1,10.3",
  "3o,34.4,22.3,16.3,12.8,10.7,9.3,8.3,7.5,6.8",
  "2s,36.3,24.6,18.8,15.7,13.7,12.3,11.2,10.4,9.6",
  "2o,32.5,20.5,14.7,11.5,9.5,8.3,7.3,6.6,6.0",
  "3,53.7,33.5,23.9,19.0,16.2,14.6,13.5,12.6,12.0",
  "2s,35.1,23.6,18.0,14.9,13.0,11.7,10.7,9.9,9.2",
  "2o,31.2,19.5,13.9,10.8,8.9,7.7,6.8,6.1,5.6",
  "2,50.3,30.7,22.0,17.8,15.5,14.2,13.3,12.5,12.0"]