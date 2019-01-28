module.exports = function( collection, item, field, options ){
  console.log(collection)
	if (collection.find(it => it[field] === item[field])){
    return options.fn(this);
  }
	return options.inverse(this);
};