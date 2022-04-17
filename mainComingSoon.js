const days = document.getElementById("days");
const hours = document.getElementById("hours");
const minutes = document.getElementById("minutes");
const seconds = document.getElementById("seconds");

// get element for the phrases

const dee = document.querySelector(".dee");
const Hr = document.querySelector(".Hr");
const min = document.querySelector(".min");
const sec = document.querySelector(".sec");

const countDown = function () {
  const targetDate = new Date("Apr 30, 2022 00:00:00").getTime();
  const now = new Date().getTime();

  const launchTime = targetDate - now;

  // How time works where;"h" = 'hours', "s" = 'seconds' "m" = 'minutes' "d" = 'day'
  const s = 1000;
  const m = s * 60;
  const h = m * 60;
  const d = h * 24;

  const launchDay = Math.floor(launchTime / d);
  const launchHour = Math.floor((launchTime % d) / h);
  const launchMinute = Math.floor((launchTime % h) / m);
  const launchSecond = Math.floor((launchTime % m) / s);

  console.log(launchSecond, launchMinute);

  // updating result on the HTML
  days.innerHTML = launchDay < 10 ? "0" + launchDay : launchDay;
  hours.innerHTML = launchHour < 10 ? "0" + launchHour : launchHour;
  minutes.innerHTML = launchMinute < 10 ? "0" + launchMinute : launchMinute;
  seconds.innerHTML = launchSecond < 10 ? "0" + launchSecond : launchSecond;

  // at the wrap of CountDown

  if (targetDate < 0) {
    clearInterval(countDown);
    days.innerHTML = 00;
    hours.innerHTML = 00;
    minutes.innerHTML = 00;
    seconds.innerHTML = 00;
  }

  // For proper phrases

  if (launchDay < 2) {
    dee.textContent = "Day";
  } else {
    dee.textContent = "Days";
  }

  if (launchHour < 2) {
    Hr.textContent = "Hour";
  } else {
    Hr.textContent = "Hours";
  }

  if (launchMinute < 2) {
    min.textContent = "Minute";
  } else {
    min.textContent = "Minutes";
  }

  if (launchSecond < 2) {
    sec.textContent = "Second";
  } else {
    sec.textContent = "Seconds";
  }
};
setInterval(countDown, 1000);
// setInterval(countDown, 1000);
// const countDownDate = new Date("Apr 30, 2022 00:00:00").getTime();
// const x = setInterval(function () {
//   const now = new Date().getTime();
//   const distance = countDownDate - now;

//   var days = Math.floor(distance / (1000 * 60 * 60 * 24));
//   var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
//   var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
//   var seconds = Math.floor((distance % (1000 * 60)) / 1000);

//   document.getElementById("days").innerHTML = days;
//   document.getElementById("hours").innerHTML = hours;
//   document.getElementById("minutes").innerHTML = minutes;
//   document.getElementById("seconds").innerHTML = seconds;

// if (distance < 0) {
//   clearInterval(x);
//   document.getElementById("days").innerHTML = 00;
//   document.getElementById("hours").innerHTML = 00;
//   document.getElementById("minutes").innerHTML = 00;
//   document.getElementById("seconds").innerHTML = 00;
// }
// }, 1000);
