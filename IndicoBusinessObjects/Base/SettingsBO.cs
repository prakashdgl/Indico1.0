// This file is generated by CodeSmith. Do not edit. All edits to this file will be lost. 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Reflection;
using System.Xml.Serialization;

using Indico.DAL;

//namespace Indico.BusinessObjects
namespace Indico.BusinessObjects
{
    /// <summary>
    /// 
    /// </summary>
    public partial class SettingsBO : BusinessObject, IComparable
    {
        #region fields
        #region Scalar Fields
        private int id;
        private string _key = string.Empty;
        private string _name = string.Empty;
        private string _value;
        #endregion
        
        #region Foreign Key fields
        #endregion
        
        #region Foreign Table Foreign Key fields
        #endregion
        
        #region Other fields
        
        private Indico.DAL.Settings _objDAL = null;
        private bool _doNotUpdateDALObject = false;
        
        #endregion
        
        #endregion
        
        #region Properties
        /// <summary>The Primary Key for this object</summary>
        public int ID
        {   get {return id;}
            set 
            {
                OnIDChanging(value);
                id = value;
                OnIDChanged();
            }
        }
        
        /// <summary>The key of the Settings. The maximum length of this property is 8.</summary>
        public string Key
        {   
            get {return _key;}
            set 
            {
                OnKeyChanging(value);
                _key = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.Key = value;
                }
                OnKeyChanged();
            }
        }
        /// <summary>The name of the Settings. The maximum length of this property is 128.</summary>
        public string Name
        {   
            get {return _name;}
            set 
            {
                OnNameChanging(value);
                _name = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.Name = value;
                }
                OnNameChanged();
            }
        }
        /// <summary>The value of the Settings. The maximum length of this property is 256.</summary>
        public string Value
        {   
            get {return _value;}
            set 
            {
                OnValueChanging(value);
                _value = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.Value = value;
                }
                OnValueChanged();
            }
        }
        
        internal Indico.DAL.Settings ObjDAL
        {
            get 
            {
                if (_objDAL == null && base._createDAL)
                {
                    _objDAL = this.SetDAL(this.Context.Context);
                    this.ObjDAL.PropertyChanged += new System.ComponentModel.PropertyChangedEventHandler(obj_PropertyChanged);
                }

                return _objDAL;
            }
            set 
            {
                _objDAL = value;
            }
        }
        
        #endregion
        
        #region Non-scalar Properties
        
        #region Foreign Key Objects
        #endregion
        
        #region Foreign Object Foreign Key Collections
        #endregion
        
        #endregion
        
        #region Internal Constructors
        /// <summary>
        /// Creates an instance of the SettingsBO class using the supplied Indico.DAL.Settings. 
        /// </summary>
        /// <param name="obj">a Indico.DAL.Settings whose properties will be used to initialise the SettingsBO</param>
        internal SettingsBO(Indico.DAL.Settings obj, ref IndicoContext context)
        {
            this._doNotUpdateDALObject = true;
            
            this.Context = context;
        
            // set the properties from the Indico.DAL.Settings 
            this.ID = obj.ID;
            
            this.Key = obj.Key;
            this.Name = obj.Name;
            this.Value = obj.Value;
            
            this._doNotUpdateDALObject = false;
        }
        #endregion
        
        #region Internal utility methods
        internal Indico.DAL.Settings SetDAL(IndicoEntities context)
        {
            this._doNotUpdateDALObject = true;
        
            // set the Indico.DAL.Settings properties
            Indico.DAL.Settings obj = new Indico.DAL.Settings();
            
            if (this.ID > 0)
            {
                obj = context.Settings.FirstOrDefault<Settings>(o => o.ID == this.ID);
            }
            
            obj.Key = this.Key;
            obj.Name = this.Name;
            obj.Value = this.Value;
            
            
            
            this._doNotUpdateDALObject = false;
            
            return obj;
        }
        
        internal void SetBO(System.Data.Objects.DataClasses.EntityObject eObj)
        {
            this._doNotUpdateDALObject = true;
            
            // Check the received type
            if (eObj.GetType() != typeof(Indico.DAL.Settings))
            {
                throw new FormatException("Received wrong parameter type...");
            }

            Indico.DAL.Settings obj = (Indico.DAL.Settings)eObj;
            
            // set the Indico.BusinessObjects.SettingsBO properties
            this.ID = obj.ID;
            
            this.Key = obj.Key;
            this.Name = obj.Name;
            this.Value = obj.Value;
            
            
            this._doNotUpdateDALObject = false;
        }
        
        internal void SetBO(Indico.BusinessObjects.SettingsBO obj)
        {
            this._doNotUpdateDALObject = true;
            
            // set this Indico.BusinessObjects.SettingsBO properties
            this.ID = obj.ID;
            
            this.Key = obj.Key;
            this.Name = obj.Name;
            this.Value = obj.Value;
            
            this._doNotUpdateDALObject = false;
        }
        
        internal List<Indico.BusinessObjects.SettingsBO> IQueryableToList(IQueryable<Indico.DAL.Settings> oQuery)
        {
            List<Indico.DAL.Settings> oList = oQuery.ToList();
            List<Indico.BusinessObjects.SettingsBO> rList = new List<Indico.BusinessObjects.SettingsBO>(oList.Count);
            foreach (Indico.DAL.Settings o in oList)
            {
                Indico.BusinessObjects.SettingsBO obj = new Indico.BusinessObjects.SettingsBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal List<Indico.BusinessObjects.SettingsBO> ToList(IEnumerable<Indico.DAL.Settings> oQuery)
        {
            List<Indico.DAL.Settings> oList = oQuery.ToList();
            List<Indico.BusinessObjects.SettingsBO> rList = new List<Indico.BusinessObjects.SettingsBO>(oList.Count);
            foreach (Indico.DAL.Settings o in oList)
            {
                Indico.BusinessObjects.SettingsBO obj = new Indico.BusinessObjects.SettingsBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal static List<Indico.DAL.Settings> ToEntityList(List<SettingsBO> bos, IndicoEntities context)
        {
            // build a List of Settings entities from the business objects
            List<Int32> ids = (from o in bos
                                   select o.ID).ToList<Int32>();

            return (context.Settings.Count() == 0) ? new List<Indico.DAL.Settings>() : (context.Settings.Where(BuildContainsExpression<Settings, int>(e => e.ID, ids)))
                .ToList<Indico.DAL.Settings>();
        }
        
        internal static System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.Settings> ToEntityCollection(List<SettingsBO> bos, IndicoEntities context)
        {
            // build an EntityCollection of Settings entities from the business objects
            List<Int32> ids = (from o in bos
                               select o.ID).ToList<Int32>();

            List<Indico.DAL.Settings> el = (context.Settings.Count() == 0) ? new List<Indico.DAL.Settings>() : 
                context.Settings.Where(BuildContainsExpression<Settings, int>(e => e.ID, ids))
                .ToList<Indico.DAL.Settings>();
                
            System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.Settings> ec 
                = new System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.Settings>();
                
            foreach (Indico.DAL.Settings r in el) 
            {
                ec.Add(r);
            }
            return ec;
        }

        internal Indico.DAL.Settings ToEntity(IndicoEntities context)
        {
            return (from o in context.Settings
                    where o.ID == this.ID
                    select o).FirstOrDefault();
        }
        #endregion
        
        #region BusinessObject methods
        
        #region Add Object
        
        public void Add()
        {
            if (this.Context != null)
            {
                this.Context.Context.AddToSettings(this.ObjDAL);
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.Settings obj = this.SetDAL(objContext.Context);
                objContext.Context.AddToSettings(obj);
                objContext.SaveChanges();
                objContext.Dispose(); 
            }
        }
        
        #endregion
        
        #region Delete Object
        
        public void Delete()
        {
            if (this.Context != null)
            {
                if (this.ObjDAL != null && this.ObjDAL.EntityKey != null)
                {
                    if (this.ObjDAL.EntityState == System.Data.EntityState.Detached)
                    {
                        this.Context.Context.Attach(this.ObjDAL);
                        this.Context.Context.DeleteObject(this.ObjDAL);
                    }
                    else
                    {
                        this.Context.Context.DeleteObject(this.ObjDAL);
                    }
                }
                else
                {
                    Indico.DAL.Settings obj = this.SetDAL(this.Context.Context);
                    this.Context.Context.DeleteObject(obj);
                }
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.Settings obj = this.SetDAL(objContext.Context);
                this.Context.Context.DeleteObject(obj);
                objContext.Context.SaveChanges();
                objContext.Dispose();
            }
        }
        
        #endregion
        
        #region Get Single Object
        
        public bool GetObject()
        {
            return GetObject(true);
        }
        public bool GetObject(bool blnCache)
        {
            Indico.BusinessObjects.SettingsBO data = null;
            
            if (blnCache)
            {
                data = this.GetFromCache(this.ID) as Indico.BusinessObjects.SettingsBO; 
            }

            if (data != null)
            {
                SetBO(data);
            }
            else
            {
                try
                {
                    IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
                    IQueryable<Indico.DAL.Settings> oQuery =
                        from o in context.Settings
                        where o.ID == this.ID
                        select o;

                    List<Indico.DAL.Settings> oList = oQuery.ToList();
                    if (oList.Count != 1)
                        return false;
                    else
                    {
                        SetBO(oList[0]);
                        this.Cache();
                    }
                    
                    if (this.Context == null)
                    {
                        context.Dispose();
                    }
                }
                catch (System.Exception e)
                {
                    throw new IndicoException(String.Format(System.Globalization.CultureInfo.InvariantCulture, ResourceManager.GetString("Could not Retrieve a {0} from the data store", System.Globalization.CultureInfo.CurrentCulture), this.ToString()), e, IndicoException.Severities.USER, IndicoException.ERRNO.INT_ERR_BO_SELECT_FAIL);
                }
            }
            return true;
        }
        #endregion
        
        #region GetAllObject
        public List<Indico.BusinessObjects.SettingsBO> GetAllObject()
        {
            return GetAllObject(0, 0);
        }
        public List<Indico.BusinessObjects.SettingsBO> GetAllObject(int maximumRows)
        {
            return GetAllObject(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.SettingsBO> GetAllObject(int maximumRows, int startIndex)
        {
            return GetAllObject(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.SettingsBO> GetAllObject(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = new IndicoEntities();
            IQueryable<Indico.DAL.Settings> oQuery =
                (from o in context.Settings
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.SettingsBO> settingss = IQueryableToList(oQuery);
            context.Dispose();
            return settingss;
        }
        #endregion
        
        #region SearchObjects
        public List<Indico.BusinessObjects.SettingsBO> SearchObjects()
        {
            return SearchObjects(0,0);
        }
        public List<Indico.BusinessObjects.SettingsBO> SearchObjects(int maximumRows)
        {
            return SearchObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.SettingsBO> SearchObjects(int maximumRows, int startIndex)
        {
            return SearchObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.SettingsBO> SearchObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.Settings> oQuery =
                (from o in context.Settings
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.Name == string.Empty || this.Name == o.Name) &&
                    (this.Key == string.Empty || this.Key == o.Key) &&
                    (this.Value == null || this.Value == o.Value) 
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.SettingsBO> settingss = IQueryableToList(oQuery);
            
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return settingss;
        }
        
        public int SearchObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.Settings
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.Name == string.Empty || this.Name == o.Name) &&
                    (this.Key == string.Empty || this.Key == o.Key) &&
                    (this.Value == null || this.Value == o.Value) 
                 orderby o.ID
                 select o).Count();
        }
        #endregion
        
        #region SearchObjectsLikeAnd
        public List<Indico.BusinessObjects.SettingsBO> SearchLikeAndObjects()
        {
            return SearchLikeAndObjects(0);
        }
        public List<Indico.BusinessObjects.SettingsBO> SearchLikeAndObjects(int maximumRows)
        {
            return SearchLikeAndObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.SettingsBO> SearchLikeAndObjects(int maximumRows, int startIndex)
        {
            return SearchLikeAndObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.SettingsBO> SearchLikeAndObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.Settings> oQuery =
                (from o in context.Settings
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.Name == string.Empty || o.Name.Contains(this.Name)) &&
                    (this.Key == string.Empty || o.Key.Contains(this.Key)) &&
                    (this.Value == null || o.Value.Contains(this.Value)) 
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.SettingsBO> settingss = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return settingss;
        }
        
        public int SearchLikeAndObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.Settings
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.Name == string.Empty || o.Name.Contains(this.Name)) &&
                    (this.Key == string.Empty || o.Key.Contains(this.Key)) &&
                    (this.Value == null || o.Value.Contains(this.Value)) 
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region SearchObjectsLikeOr
        public List<Indico.BusinessObjects.SettingsBO> SearchLikeOrObjects()
        {
            return SearchLikeOrObjects(0);
        }
        public List<Indico.BusinessObjects.SettingsBO> SearchLikeOrObjects(int maximumRows)
        {
            return SearchLikeOrObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.SettingsBO> SearchLikeOrObjects(int maximumRows, int startIndex)
        {
            return SearchLikeOrObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.SettingsBO> SearchLikeOrObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.Settings> oQuery =
                (from o in context.Settings
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    ((o.Name.Contains(this.Name)) ||
                    (o.Key.Contains(this.Key)) ||
                    (o.Value.Contains(this.Value)) ||
                    (this.Name == null && this.Key == null && this.Value == null ))
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.SettingsBO> settingss = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return settingss;
        }
        
        public int SearchLikeOrObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.Settings
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    ((o.Name.Contains(this.Name)) ||
                    (o.Key.Contains(this.Key)) ||
                    (o.Value.Contains(this.Value)) ||
                    (this.Name == null && this.Key == null && this.Value == null ))
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region Serialization methods
        /// <summary>
        /// Serializes the Indico.BusinessObjects.SettingsBO to an XML representation
        /// </summary>
        /// <returns>a XML string serialized representation</returns>
        public string SerializeObject()
        {
            string strReturn = "";

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();

            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            x.Serialize(objStream, this);

            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            // Read string from binary file with UTF8 encoding
            strReturn = encoding.GetString(objStream.GetBuffer());

            objStream.Close();
            return strReturn;

        }

        /// <summary>
        /// Deserializes Indico.BusinessObjects.SettingsBO object from an XML representation
        /// </summary>
        /// <param name="strXML">a XML string serialized representation</param>
        public Indico.BusinessObjects.SettingsBO DeserializeObject(string strXML)
        {
            Indico.BusinessObjects.SettingsBO objTemp = null;
            System.Xml.XmlDocument objXML = new System.Xml.XmlDocument();

            objXML.LoadXml(strXML);
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();
            byte[] b = encoding.GetBytes(objXML.OuterXml);

            objStream.Write(b, 0, (int)b.Length);
            objStream.Position = 0;
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            objTemp = (Indico.BusinessObjects.SettingsBO)x.Deserialize(objStream);
            objStream.Close();
            return objTemp;
        }

        /// <summary>
        /// Returns a simple XML representation of Indico.BusinessObjects.SettingsBO object in an XmlElement
        /// </summary>
        /// <returns>An XML snippet representing the object</returns>
        public string ToXmlString()
        {
            // MW TODO - implement this better.
            return SerializeObject();
        }
        #endregion
        
        #region OnPropertyChange Methods
        partial void OnIDChanged()
        {
            OnSettingsBOIDChanged();
        }
        
        partial void OnIDChanging(int value)
        {
            if (value < 0)
            {
                throw new Exception(String.Format("SettingsBO.ID must be more than or equal to 0. The supplied value was {0}.", value));
            }
            OnSettingsBOIDChanging(value);
        }
        partial void OnIDChanged();
        partial void OnIDChanging(int value);
        partial void OnSettingsBOIDChanged();
        partial void OnSettingsBOIDChanging(int value);
        
        partial void OnNameChanged()
        {
            OnSettingsBONameChanged();
        }
        
        partial void OnNameChanging(string value)
        {
            if (value != null && value.Length > 128)
            {
                throw new Exception(String.Format("SettingsBO.Name has a maximum length of 128. The supplied value \"{0}\" has a length of {1}", value, value.Length));
            }
            OnSettingsBONameChanging(value);
        }
        partial void OnNameChanged();
        partial void OnNameChanging(string value);
        partial void OnSettingsBONameChanged();
        partial void OnSettingsBONameChanging(string value);
        
        partial void OnKeyChanged()
        {
            OnSettingsBOKeyChanged();
        }
        
        partial void OnKeyChanging(string value)
        {
            if (value != null && value.Length > 8)
            {
                throw new Exception(String.Format("SettingsBO.Key has a maximum length of 8. The supplied value \"{0}\" has a length of {1}", value, value.Length));
            }
            OnSettingsBOKeyChanging(value);
        }
        partial void OnKeyChanged();
        partial void OnKeyChanging(string value);
        partial void OnSettingsBOKeyChanged();
        partial void OnSettingsBOKeyChanging(string value);
        
        partial void OnValueChanged()
        {
            OnSettingsBOValueChanged();
        }
        
        partial void OnValueChanging(string value)
        {
            if (value != null && value.Length > 256)
            {
                throw new Exception(String.Format("SettingsBO.Value has a maximum length of 256. The supplied value \"{0}\" has a length of {1}", value, value.Length));
            }
            OnSettingsBOValueChanging(value);
        }
        partial void OnValueChanged();
        partial void OnValueChanging(string value);
        partial void OnSettingsBOValueChanged();
        partial void OnSettingsBOValueChanging(string value);
        
        #endregion
        
        #region IComparable Members

        public int CompareTo(object obj)
        {
            if (!(obj is Indico.BusinessObjects.SettingsBO))
                return 1;
            Indico.BusinessObjects.SettingsBOComparer c = new Indico.BusinessObjects.SettingsBOComparer();
            return c.Compare(this, obj as Indico.BusinessObjects.SettingsBO);
        }

        #endregion
        #endregion
        
        #region Events
        
        void obj_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if (e.PropertyName == "ID")
            {
                // reload me
                this.SetBO((Indico.DAL.Settings)sender);
            }
        }
        
        void Context_OnSendBeforeChanges(object sender, EventArgs e)
        {        
        }
        
        void Context_OnSendAfterChanges(object sender, EventArgs e)
        {   
            if (this.ID > 0)
            {
                this.Cache();
            }
        }

        #endregion
    }
    
    #region SettingsBOComparer
    public class SettingsBOComparer : IComparer<Indico.BusinessObjects.SettingsBO>
    {
        private string propertyToCompareName;
        public SettingsBOComparer(string propertyToCompare)
        {
            PropertyInfo p = typeof(Indico.BusinessObjects.SettingsBO).GetProperty(propertyToCompare);
            if (p == null)
                throw new ArgumentException("is not a public property of Indico.BusinessObjects.SettingsBO", "propertyToCompare");
            this.propertyToCompareName = propertyToCompare;
        }
        
        public SettingsBOComparer()
        {
        
        }

        #region IComparer<Indico.BusinessObjects.SettingsBO> Members
        public int Compare(Indico.BusinessObjects.SettingsBO x, Indico.BusinessObjects.SettingsBO y)
        {
            if (propertyToCompareName != null)
            {
                PropertyInfo p = typeof(Indico.BusinessObjects.SettingsBO).GetProperty(propertyToCompareName);
                return compare(p, x, y);
            }
            else
            {
                PropertyInfo[] arrP = typeof(Indico.BusinessObjects.SettingsBO).GetProperties();
                foreach (PropertyInfo p in arrP)
                {
                    int v = compare(p, x, y);
                    if (v != 0)
                        return v;
                }
                return 0;
            }
        }

        private int compare(PropertyInfo p, Indico.BusinessObjects.SettingsBO x, Indico.BusinessObjects.SettingsBO y)
        {
            object xVal = p.GetValue(x, null);
            object yVal = p.GetValue(y, null);

            if (xVal == null)
            {
                if (yVal == null)
                    return 0;
                else
                    return -1; // x is null, y is not, y is greater
            }
            else
            {
                if (y == null)
                    return 1; // x non null, y is null, x is greater
                else if (xVal is string)
                {
                    return StringComparer.OrdinalIgnoreCase.Compare(xVal, yVal);
                }
                else if (xVal is IComparable)
                {
                    return ((IComparable)xVal).CompareTo((IComparable)yVal);
                }
                else
                    throw new ArgumentException
                        ("is not string or valuetype that implements IComparable", "propertyToCompare");

            }
        }

        #endregion
    }
    #endregion
}
