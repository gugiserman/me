const BIRTHDATE = {
  day: 23,
  month: 12,
  year: 1994,
}

const getMyAge = () => {
  const now = new Date()
  const currentDate = {
    day: now.getUTCDate(),
    month: (now.getUTCMonth() + 1),
    year: now.getUTCFullYear(),
  }

  const monthDiff = (currentDate.month - BIRTHDATE.month)
  let age = (currentDate.year - BIRTHDATE.year)

  if (monthDiff < 0 || (monthDiff === 0 && currentDate.day < BIRTHDATE.day)) {
    age--
  }

  return age
}

export default getMyAge
