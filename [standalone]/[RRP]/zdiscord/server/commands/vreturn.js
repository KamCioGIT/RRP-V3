module.exports = {
     name: "vreturn",
     description: "Return A Bugged Vehicle",
	 role: "admin",

	options: 
     {
             name: "plate",
             description: "Plate Of Vehicle",
             required: true, // Setting this to false will make it optional
             type: "STRING",
     },
 ],

 run: async (client, interaction, args) => { 
         return interaction.reply({ content: "Returned A Vehicle To Garage" });
     },
 };
 
 