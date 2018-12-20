.pragma library

function getDomainName(url) {
    return url.replace(/^.+:\/{2}(www\.)?([^/]+).+$/g, '$2');
}

function relativeTime(previous, current) {
    current = current || new Date();

    let msPerMinute = 60 * 1000,
        msPerHour = msPerMinute * 60,
        msPerDay = msPerHour * 24,
        msPerMonth = msPerDay * 30,
        msPerYear = msPerDay * 365,
        elapsed = current - previous,
        diff, label;

    if (elapsed < msPerMinute) {
        diff = Math.round(elapsed / 1000);
        label = "second";
    } else if (elapsed < msPerHour) {
        diff = Math.round(elapsed / msPerMinute);
        label = "minute";
    } else if (elapsed < msPerDay) {
        diff = Math.round(elapsed / msPerHour);
        label = "hour";
    } else if (elapsed < msPerMonth) {
        diff = Math.round(elapsed / msPerDay);
        label = "day";
    } else if (elapsed < msPerYear) {
        diff = Math.round(elapsed / msPerMonth);
        label = "month";
    } else {
        diff = Math.round(elapsed / msPerYear);
        label = "year";
    }

    if (diff > 1) label += "s";
    return diff + " " + label + " ago";
}