import './CatItem.css'

const CatItem = ({ cat }) => {
  return (
    <div class='CatItem'>
      <div class='Wrap'>
        <img src={cat.imageUrl} alt="" />
      </div>
      <div class='Wrap'>
        <span>Name: {cat.name}</span>
      </div>
      <div class='Wrap'>
        <span>Breed: {cat.breed}</span>
      </div>
      <div class='Wrap'>
        <span>Weight kg: {cat.weightKg}</span>
      </div>
      <div class='Wrap'>
        <span>Weight lbs: {cat.weightLbs}</span>
      </div>
      <div class='Wrap'>
        <span>Age(years): {cat.ageYears}</span>
      </div>
      <div class='Wrap'>
        <span>Age(months): {cat.ageMonths}</span>
      </div>
    </div>
  )
}

export default CatItem
