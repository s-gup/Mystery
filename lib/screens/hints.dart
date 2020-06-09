class HintModel {
  String getFalseHint(int key) {
    switch (key) {
      case 1:
        return "Was addicted to drugs, his girlfriend broke up to him because she loves X , due to which he becomes depressed and started having anxiety disorders";

      case 2:
        return "Rival of X in college, a law abiding student, jealous of X, went to same school, his bracelet was found near dead body of X ";
      case 3:
        return "He and X were working on a big coding project together on github for few months and was completed a day before death, their github repositary is publicly available , he does not want anyone to know about X having the major contribution in code. GITHUB is an open source version control system in which every developer can see these new changes in code, download them, and contribute the changes";
      case 4:
        return "Brother of X , loves his family the most ,a lot more than himself , but he loves the girlfriend of X , he was last seen with X and their common friend before his death ";
      case 5:
        return "";
    }
    return "";
  }

  String getTrueHint(int key) {
    switch (key) {
      case 5:
        return "He lost a rummy match first time in his life to X , very angry, selfish and egoistic man  ";
      case 2:
        return "";
      case 3:
        return "";
      case 4:
        return "";
      case 7:
        return "";
    }
    return "";
  }

  String getTrueReasons(int key) {
    switch (key) {
      case 1:
        return " He can't kill X as he is having anxiety disorders !! ";
      case 2:
        return " He can't kill X as he is a law abiding student !!";
      case 3:
        return " He can't kill X since the code is on github and thus the public knows that X has major contribution , so there will be no benefit of him. ";
      case 4:
        return " He can't kill X as he loves his family the most, so he would not kill his brother";
    }
    return "";
  }

  String getFalseReasons(int key) {
    switch (key) {
      case 5:
        return "He must ahe killed X to satisfy hi ego !!";
    }
    return "";
  }
}
