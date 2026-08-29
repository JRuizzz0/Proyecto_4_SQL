-- 1. Vuelos con estado 'On Time'
SELECT flight_id, route_no, status, scheduled_departure, scheduled_arrival
FROM flights
WHERE status = 'On Time';

-- 2. Reservas con importe total mayor a 1.000.000
SELECT *
FROM bookings
WHERE total_amount > 1000000;

-- 3. Datos de los modelos de aviones disponibles
SELECT *
FROM airplanes_data;

-- 4. Identificadores de vuelos operados por un Boeing 737 (Código 733)
SELECT f.flight_id, f.route_no, r.airplane_code
FROM flights f
JOIN routes r ON f.route_no = r.route_no
WHERE r.airplane_code = '733';

-- 5. Información detallada de tickets de personas llamadas Irina
SELECT *
FROM tickets
WHERE passenger_name ILIKE 'IRINA %' 
   OR passenger_name ILIKE 'IRINA';

-- 6. Ciudades con más de un aeropuerto
SELECT city AS city_name, COUNT(*) AS total_aeropuertos
FROM airports_data
GROUP BY city
HAVING COUNT(*) > 1;

-- 7. Número de vuelos por modelo de avión
SELECT 
    a.airplane_code,
    a.model AS airplane_model,
    COUNT(f.flight_id) AS total_flights
FROM airplanes_data a
JOIN routes r ON a.airplane_code = r.airplane_code
JOIN flights f ON r.route_no = f.route_no
GROUP BY a.airplane_code, a.model
ORDER BY total_flights DESC;

-- 8. Reservas con más de un billete (varios pasajeros)
SELECT book_ref, COUNT(ticket_no) AS total_pasajeros
FROM tickets
GROUP BY book_ref
HAVING COUNT(ticket_no) > 1
ORDER BY total_pasajeros DESC;

-- 9. Vuelos con retraso de salida superior a una hora
SELECT 
    flight_id,
    route_no,
    scheduled_departure,
    actual_departure,
    (actual_departure - scheduled_departure) AS retraso
FROM flights
WHERE actual_departure IS NOT NULL
  AND actual_departure - scheduled_departure > INTERVAL '1 hour'
ORDER BY retraso DESC;