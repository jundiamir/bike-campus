package main

import ( 
 "fmt"
 "log"
 "net/http"
 "encoding/json"
 "database/sql"
 //"io"
 _ "github.com/go-sql-driver/mysql"
 //"strconv"
 )
  


func main() {
	 
	port := 8181
	http.HandleFunc("/bike/", func(w http.ResponseWriter, r *http.Request){
		switch r.Method {
		case "GET" :
			s := r.URL.Path[len("/bike/"):]
			if s != "" {
				GetBikeAtShelter(w,r,s)
			} else {
				GetAllBike(w,r)
			}
		//case "POST" : PostNewUser(w,r)
		
		//case "DELETE" :
		//	default : http.Error(w, "Invalid Method", 405)
		}
	})
	
	http.HandleFunc("/peminjaman/", func(w http.ResponseWriter, r *http.Request){
		switch r.Method {
		case "GET" :
			//s := r.URL.Path[len("/peminjaman/"):]
			//if s != "" {
				//GetUser(w,r,s)
			//} else {
				GetAllPeminjaman(w,r)
			//}
		//case "POST" : PostNewUser(w,r)
		
		//case "DELETE" :
		//	default : http.Error(w, "Invalid Method", 405)
		}
	})
	
	log.Printf("Server starting on port %v\n", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%v",port),nil))
}

type Sepeda struct{
	id_sepeda string
	kondisi string
}

func GetAllBike(w http.ResponseWriter, r *http.Request) {
	db, err := sql.Open("mysql", "root:@tcp(127.0.0.1:3306)/bike@campus")
	
	if err!= nil {
		log.Fatal(err)
	}
	defer db.Close()

	sepeda := Sepeda{};

	rows, err := db.Query("SELECT id_sepeda,kondisi from sepeda")
	if err!= nil {
		log.Fatal(err)
	}
	defer db.Close()

	for rows.Next() {
		err := rows.Scan(&sepeda.id_sepeda, &sepeda.kondisi)
		fmt.Println(sepeda.id_sepeda, sepeda.kondisi)
		
		if err!= nil {
			log.Fatal(err)
		}
		
		json.NewEncoder(w).Encode(sepeda);
	}
	err = rows.Err()

}

type Peminjaman struct {
	no_peminjaman int
	no_induk string
	id_sepeda string
	no_shelter_ambil int
	no_shelter_kembali int
	waktu_ambil string
	waktu_kembali string
	
}

func GetAllPeminjaman(w http.ResponseWriter, r *http.Request) {
	db, err := sql.Open("mysql", "root:@tcp(127.0.0.1:3306)/bike@campus")
	
	if err!= nil {
		log.Fatal(err)
	}
	defer db.Close()

	peminjaman := Peminjaman{};

	rows, err := db.Query("SELECT no_peminjaman, no_induk, id_sepeda, no_shelter_ambil, no_shelter_kembali, waktu_ambil, waktu_kembali from peminjaman")
	if err!= nil {
		log.Fatal(err)
	}
	defer db.Close()

	for rows.Next() {
		err := rows.Scan(&peminjaman.no_peminjaman, &peminjaman.no_induk, &peminjaman.id_sepeda, &peminjaman.no_shelter_ambil, &peminjaman.no_shelter_kembali, &peminjaman.waktu_ambil, &peminjaman.waktu_kembali)
		
		fmt.Println(peminjaman.no_peminjaman, peminjaman.no_induk, peminjaman.id_sepeda, peminjaman.no_shelter_ambil, peminjaman.no_shelter_kembali, peminjaman.waktu_ambil, peminjaman.waktu_kembali)
	
		if err!= nil {
			log.Fatal(err)
		}
		
		json.NewEncoder(w).Encode(peminjaman)
	}
	err = rows.Err()

}

type Shelter struct {
	no_shelter int	
	lokasi string
	kapasitas int
	jumlah_sepeda int 
}

func GetBikeAtShelter(w http.ResponseWriter, r *http.Request, l string) {
	//lokasi, _ := strconv.Atoi(lokasi)

	db, err := sql.Open("mysql", "root:@tcp(127.0.0.1:3306)/bike@campus")
	
	if err!= nil {
		log.Fatal(err)
	}
	defer db.Close()

	shelter := Shelter{};

	rows, err := db.Query("select lokasi,jumlah_sepeda from shelter WHERE lokasi = ?", l)
	
	if err!= nil {
		log.Fatal(err)
	}

	defer db.Close()

	for rows.Next() {
		err := rows.Scan(&shelter.lokasi, &shelter.jumlah_sepeda)
		if err!= nil {
			log.Fatal(err)
		}
		
		fmt.Println(shelter.lokasi, shelter.jumlah_sepeda)
		json.NewEncoder(w).Encode(shelter);
	}
	err = rows.Err()
}


//func PostNewUser(w http.ResponseWriter, r *http.Request) {
//	out := make([] byte, 1024)
//
//	bodyLen, err := r.Body.Read(out)
//
//	if err != io.EOF {
//		fmt.Printf(err.Error())
//		w.Write([]byte("{error:" + err.Error() + "}"))
//		return
//	} 
//	var k MyUser
//	err = json.Unmarshal(out[:bodyLen],&k)
//	if err != nil {
//		w.Write([]byte("{error:" + err.Error() + "}"))
//		return
//	}

//	idx := insertInDatabase(k)
//	log.Printf(" ID Baru %d",idx)
//	w.Write([]byte(`{"error":"success"}`))
//}

//func insertInDatabase(data MyUser) int64 {
//	log.Printf(data.FirstName)
//	db, err := sql.Open("mysql", "root@127.0.0.1:3306/bike@campus")
//	
//	if err!= nil {
//		log.Fatal(err)
//	}
//	defer db.Close()
//
//	result, err := db.Exec("INSERT INTO user (FirstName, LastName, City, Country) VALUES(?,?,?,?) ", data.FirstName, data.LastName, data.City, data.Country)
//	
	
	
//	if err != nil {
//		log.Fatal(err)
//	}
//	//log.Printf(result);
//	lastid,_ := result.LastInsertId(); 
//	return lastid
//}
//Penggunaan 
//curl POST -H "Content-Type: application/json" -d '{"FirstNme":"Spark","City":"Jakarta","Country":"ID"}' http://localhost:8181/users/ -v
